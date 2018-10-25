//
//  ModelTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iADSB

class ModelTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(_ model:IADSB.Model) {
        
    }
}
