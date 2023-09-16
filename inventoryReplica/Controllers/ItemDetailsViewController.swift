//
//  ItemDetailsViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 25/07/23.
//

import Foundation
import UIKit

class ItemDetailsViewController : UIViewController {
    
    var currentItem : Item?
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var minLevelLabel: UILabel!
    @IBOutlet weak var maxLevelLabel: UILabel!
    @IBOutlet weak var unitaryPriceLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    override func viewDidLoad() {
        let customItem = Item(name: "custom", quantity: 20, images: [], sortlyId: "id123", createdAt: Date.now, updatedAt: Date.now)
        
        if let item = currentItem {
            configure(with: item)
        }
            
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
    @IBAction func editNotesPressed(_ sender: UIButton) {
    }
    
    @IBAction func editTagsPressed(_ sender: UIButton) {
    }
    
    func configure(with item : Item) {
        // Mandatory props
        
        self.navigationItem.title = item.name
        quantityLabel.text = String(item.quantity)
        lastUpdateLabel.text = item.updatedAt.formatted()

        if item.images.count != 0 {
            itemImage.image = item.images.first
        }

        if let minLevel = item.minLevel {
            minLevelLabel.text = String(minLevel)
        }

        if let price = item.price {
            unitaryPriceLabel.text = String(format: "%.2f", price)
            totalValueLabel.text = String(format: "%.2f", price*Float(item.quantity))
        }
        

        
        
        
    }
}
