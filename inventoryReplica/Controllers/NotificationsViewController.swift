//
//  NotificationsViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 26/07/23.
//

import UIKit
import SwipeCellKit

class NotificationsViewController : UIViewController {
    
    @IBOutlet weak var scheduleNotificationButton : UIButton!
    @IBOutlet weak var notificationsTableView : UITableView!
    
    
    var notifications = [CustomNotification]()
    var currentNotification : CustomNotification?
    
    override func viewDidLoad() {
        styleContent()
        
        // TableView
        notificationsTableView.dataSource = self
        notificationsTableView.delegate = self
        notificationsTableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        
        
        //PubSub
        NotificationCenter.default.addObserver(self, selector: #selector(handleCustomNotification), name: K.Events.newNotification, object: nil)
        
        // Load data
        loadData()
        
    }
    
    func loadData() {
        let notificationManager = NotificationManager()
        notificationManager.queryNotifications { notifications in
            self.notifications = notifications
            self.updateUI()
        }
    }
    
    
    func updateUI() {
        notificationsTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: K.Events.newNotification, object: nil)
    }
    
    
    
    @objc func handleCustomNotification() {
        print("new Event!")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
}


extension NotificationsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let notification = notifications[indexPath.row]
        
        cell.delegate = self
        cell.configure(with: notification)
        return cell
    }
    
    
}

extension NotificationsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("preparing!")
        let notification = NotificationManager.notifications[indexPath.row]
        currentNotification = notification
        self.performSegue(withIdentifier: "NotificationsToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NotificationsToDetails" {
            if let viewController = segue.destination as? NotificationDetailsViewController, let notification = currentNotification {
                viewController.currentNotification = notification
            }
        }
        
    }
}

extension NotificationsViewController : SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            let notification = self.notifications[indexPath.row]
            self.notifications.remove(at: indexPath.row)
            action.fulfill(with: .delete)
            
            notification.delete { error, ref in
                if error == nil {
                    print("success")
                } else {
                    print(error)
                }
            }
            
            
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
}
