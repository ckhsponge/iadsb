//
//  BarometerTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//


import UIKit
import iADSB

class BarometerTableViewCell: ModelTableViewCell {
    @IBOutlet var providerLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var temperatureFarenheitLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var verticalSpeedLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    
    override func update(_ model:IADSB.Model) {
        providerLabel.text = model.providerName
        guard let barometer = model as? IADSB.Barometer else {
            providerLabel.text = "none"
            temperatureLabel.text = ""
            temperatureFarenheitLabel.text = ""
            altitudeLabel.text = ""
            verticalSpeedLabel.text = ""
            timestampLabel.text = ""
            return
        }
        temperatureLabel.text = format(barometer.temperature, precision:1, suffix:" C")
        temperatureFarenheitLabel.text = format(barometer.temperatureFarenheit, precision:1, suffix:"°F")
        altitudeLabel.text = format(barometer.pressureAltitudeFeet, precision:0, suffix:"'")
        verticalSpeedLabel.text = format(barometer.verticalSpeedFPM, precision:0, suffix:" fpm")
        timestampLabel.text = format(barometer.timestamp)
    }
}
