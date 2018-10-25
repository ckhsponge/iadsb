//
//  GPSTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/22/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iADSB

class GPSTableViewCell: ModelTableViewCell {
    @IBOutlet var providerLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var horizontalAccuracyLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var verticalSpeedLabel: UILabel!
    @IBOutlet var verticalAccuracyLabel: UILabel!
    @IBOutlet var courseTrueLabel: UILabel!
    @IBOutlet var courseMagneticLabel: UILabel!
    @IBOutlet var turnRateLabel: UILabel!
    @IBOutlet var satelliteCountLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    
    override func update(_ model:IADSB.Model) {
        providerLabel.text = model.providerName
        guard let gps = model as? IADSB.GPS else {
            providerLabel.text = "none"
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            speedLabel.text = ""
            horizontalAccuracyLabel.text = ""
            altitudeLabel.text = ""
            verticalSpeedLabel.text = ""
            verticalAccuracyLabel.text = ""
            courseTrueLabel.text = ""
            courseMagneticLabel.text = ""
            turnRateLabel.text = ""
            satelliteCountLabel.text = ""
            timestampLabel.text = ""
            return
        }
        latitudeLabel.text = format( gps.latitude, precision: 6, suffix:"°")
        longitudeLabel.text =  format( gps.longitude, precision: 6, suffix:"°")
        speedLabel.text = format( gps.speedKnots, precision: 0, suffix:" kts")
        horizontalAccuracyLabel.text = format( gps.horizontalAccuracyFeet, precision: 0, suffix:"'", prefix:"±")
        altitudeLabel.text = format( gps.altitudeFeet, precision: 0, suffix:"'" )
        verticalSpeedLabel.text = format( gps.verticalSpeedFPM, precision:0, suffix:" fpm")
        verticalAccuracyLabel.text = format( gps.verticalAccuracyFeet, precision: 0, suffix:"'", prefix:"±")
        courseTrueLabel.text =  format( gps.courseTrue, precision: 0, suffix:"°T")
        courseMagneticLabel.text =  format( gps.courseMagnetic, precision: 0, suffix:"°M")
        turnRateLabel.text = format( gps.turnRate, precision: 0, suffix:"°/s")
        satelliteCountLabel.text = format( gps.satelliteCount )
        timestampLabel.text = format( gps.timestamp )
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
