//
//  NotificationDetailsViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 27/07/23.
//

import UIKit

class NotificationDetailsViewController: UIViewController {
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var currentNotification : CustomNotification?
    let notificationManager = NotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let notification = currentNotification {
            configure(with: notification)
            if let id = notification.id {
                notificationManager.editStatus(documentID: id, newStatus: K.Notifications.read) { error in
                    if error != nil {
                        print(error)
                    }
                }
            }
        }
        
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
    func configure(with notification: CustomNotification) {
        dateLabel.text = notification.timedate.formatted()
        titleLabel.text = notification.title
        
        if let image = notification.image {
            notificationImage.image = image
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
