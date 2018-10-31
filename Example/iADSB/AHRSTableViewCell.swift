//
//  AHRSTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iADSB

class AHRSTableViewCell: ModelTableViewCell {
    @IBOutlet var providerLabel: UILabel!
    @IBOutlet var pitchLabel: UILabel!
    @IBOutlet var rollLabel: UILabel!
    @IBOutlet var skidSlipLabel: UILabel!
    @IBOutlet var headingGyroLabel: UILabel!
    @IBOutlet var headingMagneticLabel: UILabel!
    @IBOutlet var turnRateLabel: UILabel!
    @IBOutlet var gLoadLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    
    override func update(_ model:IADSB.Model) {
        providerLabel.text = model.providerName
        guard let ahrs = model as? IADSB.AHRS else {
            providerLabel.text = "none"
            pitchLabel.text = ""
            rollLabel.text = ""
            skidSlipLabel.text = ""
            headingGyroLabel.text = ""
            headingMagneticLabel.text = ""
            turnRateLabel.text = ""
            gLoadLabel.text = ""
            timestampLabel.text = ""
            return
        }
        pitchLabel.text = format(ahrs.pitch, precision:1, suffix:"°")
        rollLabel.text = format(ahrs.roll, precision:1, suffix:"°")
        skidSlipLabel.text = format(ahrs.slipSkid, precision:1)
        headingGyroLabel.text = format(ahrs.headingGyro, precision:0, suffix:"°G")
        headingMagneticLabel.text = format(ahrs.headingMagnetic, precision:0, suffix:"°M")
        turnRateLabel.text = format(ahrs.turnRate, precision:1, suffix:"°/s")
        gLoadLabel.text = format(ahrs.gLoad, precision:2)
        timestampLabel.text = format(ahrs.timestamp)
    }
}
