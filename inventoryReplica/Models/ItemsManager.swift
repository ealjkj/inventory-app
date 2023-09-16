//
//  ItemsManager.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 13/07/23.
//

import Foundation
import Firebase

struct ItemManager {
    static var items = [Item]()
    static var db = Firestore.firestore()
    
    static var totalPrice : Float {
        return items.map { item in
            if let price = item.price {
                return Float(item.quantity) * price
            } else {
                return 0
            }
        }.reduce(0, +)
    }
    
    static var itemCount : Int {
        return items.count
    }
    
    static var totalQuantity : Int {
        return items.map { item in
            return item.quantity
        }.reduce(0, +)
    }
    
    
    static func createNewId() -> String {
        return "SCVUHR0001"
    }
    
    static func queryItems(completion: @escaping ([Item]) -> Void) {
        print("loading items")
        
        db.collection(K.FStore.itemsCollectionName).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error)
            } else {
                ItemManager.items = []
                if let snapshotsDocuments = querySnapshot?.documents {
                    for doc in snapshotsDocuments {
                        let data = doc.data()
                        
                        
                        if let name = data["name"] as? String,
                            let quantity = data["quantity"] as? Int,
                            let sortlyId = data["sortlyId"] as? String,
                            let createdAt = data["createdAt"] as? Timestamp,
                           let updatedAt = data["updatedAt"] as? Timestamp {
                                let imageDatas = data["images"] as? [Data]
                                let minLevel = data["minLevel"] as? Int
                                let price = data["price"] as? Float
                                let notes = data["notes"] as? String
                                let tags = data["tags"] as? [String]
                                
                            
                            // Convert image data to UIImage objects
                            var images : [UIImage] = []
                            if let imageDatas = imageDatas {
                                images = imageDatas.compactMap { imageData in
                                    if let image = UIImage(data: imageData) {
                                        return image
                                    }
                                    return nil
                                }
                            }
        
                            let item = Item(name: name, quantity: quantity, images: images, minLevel: minLevel, price: price, notes: notes, tags: tags, sortlyId: sortlyId, createdAt: createdAt.dateValue(), updatedAt: updatedAt.dateValue())
                                
                                ItemManager.items.append(item)
                                
                        }
                    }
                    completion(ItemManager.items)
                }
                
            }
        }
    }
        
        
        
        
    
}
