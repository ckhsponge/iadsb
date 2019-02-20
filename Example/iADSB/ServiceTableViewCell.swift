//
//  ServiceTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iADSB

class ServiceTableViewCell: UITableViewCell {
    
//    let decimalFormatter:NumberFormatter = {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = NumberFormatter.Style.decimal
//        return numberFormatter
//    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(_ service:IADSB.Service) {
        // updates the service and trigger the redraw
    }
    
    func updateActive(_ label:UILabel, _ device:IADSB.Device?) {
        guard let device = device else {
            label.text = "-"
            label.textColor = UIColor.darkGray
            return
        }
        if device.active {
            label.text = "ACTIVE"
            label.textColor = UIColor.green
        } else {
            label.text = "STOPPED"
            label.textColor = UIColor.red
        }
    }
    
    func format(_ i:Int?, suffix:String="", prefix:String="") -> String {
        guard let i = i else { return "" }
        return "\(prefix)\(String.localizedStringWithFormat("%d", i))\(suffix)"
    }
    
    func format(_ d:Double?, precision:Int, prefix:String="", suffix:String="") -> String {
        guard let d = d else { return "" }
        return "\(prefix)\(String.localizedStringWithFormat("%.\(precision)f", d))\(suffix)"
    }
    
    func format(_ d:Date?) -> String {
        guard let d = d else { return "" }
        return "\(d)"
    }
}
