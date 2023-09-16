//
//  ItemCollectionViewCell.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 25/07/23.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with item: Item) {
        if let image = item.images.first {
            itemImageView.image = image
        }
        
        idLabel.text = item.sortlyId
        nameLabel.text = item.name
        unitsLabel.text = "\(item.quantity) units"
    }
    
    
}
