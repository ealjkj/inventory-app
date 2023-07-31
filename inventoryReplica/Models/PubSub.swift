//
//  NotificationManager.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 27/07/23.
//

import Foundation

class PubSub {
    static func publishNotification() {
        NotificationCenter.default.post(name: K.Events.newNotification, object: nil)
    }
}
