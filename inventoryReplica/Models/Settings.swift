//
//  Settings.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 28/07/23.
//

import Foundation
import UIKit

struct Setting {
    
    let image : UIImage?
    let text : String
    let action: () -> Void
    
    init(imageName: String, text: String, action: (() -> Void)? = nil) {
        
        func defaultAction() {
            print("Tapped setting : \(text)")
        }
        
        self.image = UIImage(systemName: imageName)
        self.text = text
        self.action = action ?? defaultAction
    }
}
