//
//  AddBorder.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 23/06/23.
//

import Foundation
import UIKit

class BorderedStackView: UIStackView {
    override func awakeFromNib() {
        super.awakeFromNib()
        addBottomBorderWithColor(color: UIColor.black, width: 1.0)
    }
    
    private func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}
