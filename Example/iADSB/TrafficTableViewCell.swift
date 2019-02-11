//
//  BarometerTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//


import UIKit
import iADSB

class TrafficTableViewCell: ServiceTableViewCell {
    @IBOutlet var deviceLabel: UILabel!
    @IBOutlet var activeLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var targetsLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    
    override func update(_ service:IADSB.Service) {
        updateActive(activeLabel, service.device)
        deviceLabel.text = service.deviceName
        guard let traffic = service as? IADSB.Traffic else {
            deviceLabel.text = "none"
            countLabel.text = ""
            timestampLabel.text = ""
            return
        }
        targetsLabel.text = traffic.targetsText
        countLabel.text = format(traffic.count)
        timestampLabel.text = format(traffic.timestamp)
    }
}
