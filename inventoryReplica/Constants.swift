//
//  Constants.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 19/07/23.
//

import Foundation

struct K {
    
    static let appName = "inventoryReplica"
    
    struct FStore {
        static let foldersCollectionName = "folders"
        static let itemsCollectionName = "items"
        static let notificationsCollectionName = "notifications"
    }
    
    struct Events {
        static let newNotification = Notification.Name("newCustomNotification")
    }
    
    struct Notifications {
        static let scheduled = "scheduled"
        static let read = "read"
        static let unread = "unread"
    }
    
}
