//
//  BarometerTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//


import UIKit
import iADSB

class TrafficTableViewCell: ModelTableViewCell {
    @IBOutlet var providerLabel: UILabel!
    @IBOutlet var activeLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var targetsLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    
    override func update(_ model:IADSB.Model) {
        updateActive(activeLabel, model.provider)
        providerLabel.text = model.providerName
        guard let traffic = model as? IADSB.Traffic else {
            providerLabel.text = "none"
            countLabel.text = ""
            timestampLabel.text = ""
            return
        }
        targetsLabel.text = traffic.targetsText
        countLabel.text = format(traffic.count)
        timestampLabel.text = format(traffic.timestamp)
    }
}
