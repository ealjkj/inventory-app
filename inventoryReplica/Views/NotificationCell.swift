//
//  NotificationCell.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 26/07/23.
//

import UIKit
import SwipeCellKit

class NotificationCell: SwipeTableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timedateLabel: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        containerView.layer.cornerRadius = 11.0
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with notification: CustomNotification) {
        
        let statusImagesDic = [
            K.Notifications.scheduled : UIImage(systemName: "clock"),
            K.Notifications.read : UIImage(systemName: "envelope.open"),
            K.Notifications.unread : UIImage(systemName: "envelope")
        ]
        
        
        titleLabel.text = notification.title
        timedateLabel.text = notification.timedate.formatted()
        
        
        if let image = statusImagesDic[notification.status] {
            statusImage.image = image
        }
        
        if let image = notification.image {
            notificationImage.image = image
        }
        
        if notification.status == K.Notifications.read {
            containerView.layer.opacity = 0.5
        }
        
    }
    
}
