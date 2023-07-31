//
//  File.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 27/07/23.
//

import UIKit

class CreateNotificationViewController : UIViewController {
    
    @IBOutlet weak var addPhotoButton : UIButton!
    @IBOutlet weak var titleTextField : UITextField!
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        styleContent()
        datePicker.minimumDate = Date.now
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if let title = titleTextField.text{
            var notification = CustomNotification(title: title, timedate: datePicker.date, status: K.Notifications.scheduled)
            notification.save { error, doc in
                if let error = error {
                    print(error)
                } else {
                    notification.id = doc?.documentID
                    self.scheduleLocalNotification(notification)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func scheduleLocalNotification(_ notification: CustomNotification) {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = "Your Notification Body"
        content.userInfo = [
            "notificationId" : notification.id!,
            "appName" : K.appName
        ]
        content.sound = UNNotificationSound.default

        // Extract the date components from the selected date
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notification.timedate)

        // Create the calendar trigger with the specified date and time
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // Create the notification request with a unique identifier
        let request = UNNotificationRequest(identifier: "YourNotificationIdentifier", content: content, trigger: trigger)

        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
}

//MARK: - Styles

extension CreateNotificationViewController {
    func styleContent() {
        centerDatePicker()
        saveButton.tintColor = .red
    }
    
    func centerDatePicker() {
        datePicker.contentHorizontalAlignment = .center
    }
    
}
