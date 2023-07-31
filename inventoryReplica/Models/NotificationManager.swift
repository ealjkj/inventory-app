//
//  NotificationManager.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 27/07/23.
//

import Foundation
import Firebase

class NotificationManager {
    
    static var notifications = [CustomNotification]()
    let db = Firestore.firestore()
    
    func queryNotifications(completion: @escaping ([CustomNotification]) -> Void) {
        print("loading notifications")
        
        db.collection(K.FStore.notificationsCollectionName).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error)
            } else {
                NotificationManager.notifications = []
                if let snapshotsDocuments = querySnapshot?.documents {
                    for doc in snapshotsDocuments {
                        let data = doc.data()
                        
                        
                        if let title = data["title"] as? String,
                           let timedate = data["timedate"] as? Timestamp,
                           let status = data["status"] as? String {
                                
                            var notification = CustomNotification(title: title, timedate: timedate.dateValue(), status: status, id: doc.documentID)
                            notification.id = doc.documentID
                            NotificationManager.notifications.append(notification)
                            completion(NotificationManager.notifications)
                        }
                    }
                }
                
            }
        }
    }
    
    func editStatus(documentID : String, newStatus : String, completion: @escaping (Error?) -> Void) {
        let ref = db.collection(K.FStore.notificationsCollectionName).document(documentID)
        ref.updateData(["status": newStatus]) { error in
            completion(error)
        }
    }
}
