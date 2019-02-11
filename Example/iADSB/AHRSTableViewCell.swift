//
//  AHRSTableViewCell.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iADSB

class AHRSTableViewCell: ServiceTableViewCell {
    @IBOutlet var deviceLabel: UILabel!
    @IBOutlet var activeLabel: UILabel!
    @IBOutlet var pitchLabel: UILabel!
    @IBOutlet var rollLabel: UILabel!
    @IBOutlet var skidSlipLabel: UILabel!
    @IBOutlet var headingGyroLabel: UILabel!
    @IBOutlet var headingMagneticLabel: UILabel!
    @IBOutlet var turnRateLabel: UILabel!
    @IBOutlet var gLoadLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    
    override func update(_ service:IADSB.Service) {
        updateActive(activeLabel, service.device)
        deviceLabel.text = service.deviceName
        guard let ahrs = service as? IADSB.AHRS else {
            deviceLabel.text = "none"
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
        skidSlipLabel.text = format(ahrs.slipSkid, precision:1, suffix:"°")
        headingGyroLabel.text = format(ahrs.headingGyro, precision:0, suffix:"°Gyro")
        headingMagneticLabel.text = format(ahrs.headingMagnetic, precision:0, suffix:"°Mag")
        turnRateLabel.text = format(ahrs.turnRate, precision:1, suffix:"°/s")
        gLoadLabel.text = format(ahrs.gLoad, precision:2)
        timestampLabel.text = format(ahrs.timestamp)
    }
}
