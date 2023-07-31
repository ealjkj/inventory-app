//
//  Item.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 09/07/23.
//

import UIKit
import Firebase

struct CustomNotification {
    var id: String?
    let title : String
    let timedate: Date
    let status: String
    let image: UIImage?
    
    let db = Firestore.firestore()

    init(title: String, timedate: Date, status: String, image : UIImage? = nil, id: String? = nil) {
        self.title = title
        self.timedate = timedate
        self.status = status
        self.image = image
    }
    
    func save(completion: @escaping (Error?, DocumentReference?) -> Void) {
        var ref : DocumentReference? = nil
        if let user = Auth.auth().currentUser?.email {
            ref = db.collection(K.FStore.notificationsCollectionName).addDocument(data: [
                "user" : user,
                "title": title,
                "timedate": timedate,
                "status": status
            ]) { error in
                if let error = error {
                    print(error)
                } else {
                    print("Successfully saved notification")
                    completion(error, ref)
                }
            }
        }
    }
    
    func delete(completion: @escaping (Error?, DocumentReference?) -> Void) {
        print("docID", self.id)
        if let _ = Auth.auth().currentUser?.email, let docID = self.id {
            print("what3?")
            let ref = db.collection(K.FStore.notificationsCollectionName).document(docID)
            ref.delete { error in
                completion(error, ref)
            }
        }
    }
    
}



