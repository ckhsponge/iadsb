//
//  GPSTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/22/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iADSB

class GPSTableViewCell: ServiceTableViewCell {
    @IBOutlet var deviceLabel: UILabel!
    @IBOutlet var activeLabel: UILabel!
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
    
    override func update(_ service:IADSB.Service) {
        updateActive(activeLabel, service.device)
        deviceLabel.text = service.deviceName
        guard let gps = service as? IADSB.GPS else {
            deviceLabel.text = "none"
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
        horizontalAccuracyLabel.text = format( gps.horizontalAccuracyFeet, precision: 0, prefix:"±", suffix:"'")
        altitudeLabel.text = format( gps.altitudeFeet, precision: 0, suffix:"'" )
        verticalSpeedLabel.text = format( gps.verticalSpeedFPM, precision:0, suffix:" fpm")
        verticalAccuracyLabel.text = format( gps.verticalAccuracyFeet, precision: 0, prefix:"±", suffix:"'")
        courseTrueLabel.text =  format( gps.courseTrue, precision: 0, suffix:"°True")
        courseMagneticLabel.text =  format( gps.courseMagnetic, precision: 0, suffix:"°Mag")
        turnRateLabel.text = format( gps.turnRate, precision: 1, suffix:"°/s")
        satelliteCountLabel.text = format( gps.satelliteCount )
        timestampLabel.text = format( gps.timestamp )
    }
}
