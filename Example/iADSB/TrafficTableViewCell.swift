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
        targetsLabel.text = format(traffic:traffic)
        countLabel.text = format(traffic.count)
        timestampLabel.text = format(traffic.timestamp)
    }
    
    public func format(traffic:IADSB.Traffic) -> String {
        let strings = traffic.targets.map { (target) -> String in
            var array:[String?] = [target.tailNumber]
//            if let squawk = target.squawk {
//                array.append(String(squawk))
//            }
            if let managerLocation = traffic.managerLocation {
                if let distance = target.distanceNM(fromLocation:managerLocation) {
                    array.append(format(distance, precision:0, suffix:"nm"))
                }
                if let heading = target.headingMagnetic(fromLocation:managerLocation) {
                    array.append(format(heading, precision:0, suffix:"°"))
                }
            } else {
                let latitude = format(target.latitude, precision:3, suffix:"°")
                let longitude = format(target.longitude, precision:3, suffix:"°")
                array.append("\(latitude),\(longitude)")
            }
            if let targetFeet = target.altitudeFeet, let managerFeet = traffic.managerGPS?.altitudeFeet {
                let difference = targetFeet - managerFeet
                array.append(format(difference, precision:0, prefix:difference >= 0.0 ? "↑" : "↓", suffix:"'"))
            } else if let targetFeet = target.altitudeFeet {
                array.append(format(targetFeet, precision:0, suffix:"'"))
            }
            if let speed = target.speedKnots {
                array.append(format(speed, precision:0, suffix:"kts"))
            }
            return array.compactMap({$0}).joined(separator: " ")
        }
        return strings.joined(separator:" • ")
    }
}
