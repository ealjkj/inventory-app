//
//  ItemFolderCell.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 09/07/23.
//

import UIKit

class ItemFolderCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImageView.layer.cornerRadius = 3
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item : Item) {
        if let image = item.images.first {
            itemImageView.image = image
        } else {
            itemImageView.image = UIImage(systemName: "doc.fill")
        }
        
        titleLabel.text = item.name
    }
    
    
}
