//
//  Item.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 09/07/23.
//

import Foundation
import UIKit

struct Item {
    let name: String
    let quantity: Int
    let images: [UIImage]
    let minLevel: Int?
    let price: Float?
    let totalValue: Float?
    let notes: String?
    let tags: [String]?
    let sortlyId: String
    let createdAt: Date
    let updatedAt: Date

    init(name: String, quantity: Int, images: [UIImage], minLevel: Int? = nil, price: Float? = nil, totalValue: Float? = nil, notes: String? = nil, tags: [String]? = nil, sortlyId: String, createdAt: Date, updatedAt: Date) {
        self.name = name
        self.quantity = quantity
        self.images = images
        self.minLevel = minLevel
        self.price = price
        self.totalValue = totalValue
        self.notes = notes
        self.tags = tags
        self.sortlyId = sortlyId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func containsPattern(_ pattern: String) -> Bool {
        if name.localizedCaseInsensitiveContains(pattern) {
            return true
        }
        
        if let tags = tags {
            for tag in tags {
                if tag.localizedCaseInsensitiveContains(pattern) {
                    return true
                }
            }
        }
        
        if let notes = notes {
            if notes.localizedCaseInsensitiveContains(pattern) {
                return true
            }
        }
        
        return false
    }
}



