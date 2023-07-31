//
//  NotificationsStyles.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 26/07/23.
//

import Foundation
import UIKit

extension NotificationsViewController {
    func styleContent() {
        addButtonImagePadding()
    }
    
    func addButtonImagePadding() {
        let spacing: CGFloat = 14

        // Apply the configuration to your button
        scheduleNotificationButton.configuration?.imagePadding = spacing
        scheduleNotificationButton.configuration?.titlePadding = spacing
        scheduleNotificationButton.tintColor = UIColor(named: "AppColor")
    }
    
    
}
