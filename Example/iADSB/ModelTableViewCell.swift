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
    
    func format(_ i:Int?, suffix:String="", prefix:String="") -> String {
        guard let i = i else { return "" }
        return "\(prefix)\(String(format: "%d", i))\(suffix)"
    }
    
    func format(_ d:Double?, precision:Int, suffix:String="", prefix:String="") -> String {
        guard let d = d else { return "" }
        return "\(prefix)\(String(format: "%.\(precision)f", d))\(suffix)"
    }
    
    func format(_ d:Date?) -> String {
        guard let d = d else { return "" }
        return "\(d)"
    }
}
