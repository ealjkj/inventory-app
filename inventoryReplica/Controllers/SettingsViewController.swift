//
//  SettingsViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 28/07/23.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    lazy var settings : [Setting] = [
        Setting(imageName:"person", text: "User Profile"),
        Setting(imageName:"gearshape", text: "Settings"),
        Setting(imageName:"archivebox", text: "Company Details"),
        Setting(imageName:"chart.pie", text: "Reports"),
        Setting(imageName:"icloud.and.arrow.up", text: "Bulk import"),
        Setting(imageName:"questionmark.circle", text: "Help"),
        Setting(imageName:"rectangle.portrait.and.arrow.right", text: "Sign Out", action: self.logout),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.text = Auth.auth().currentUser?.email
        
        // Tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")

        
    }
    
    func logout() {
        print("logging out")
        do {
            try Auth.auth().signOut()
            print("signed out, now going to rootController")
            tabBarController?.navigationController?.popViewController(animated: true)
            
        }   catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func unwindToNavigationControllerA(_ sender: UIStoryboardSegue) {
            // This method is empty because we only need it for the unwind segue to work
        }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }

}


extension SettingsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        let setting = settings[indexPath.row]
        
        cell.nameLabel.text = setting.text
        
        if let image = setting.image {
            cell.settingImage.image = image
        }
        
        return cell
    }
    

}

extension SettingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        setting.action()
    }
}


