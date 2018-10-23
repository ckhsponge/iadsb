//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Stratux {
    public class AHRS: IADSB.AHRS {
        override public class var keyMapping:[String:String]? {
            return  ["AHRSPitch": "pitch",
                     "AHRSRoll": "roll",
                     "AHRSGyroHeading": "headingGyro",
                     "AHRSMagHeading": "headingMagnetic",
                     "AHRSSlipSkid": "slipSkid",
                     "AHRSTurnRate": "turnRate",
                     "AHRSGLoad": "gLoad",
                     "AHRSGLoadMin": "gLoadMin",
                     "AHRSGLoadMax": "gLoadMax",
                     "AHRSLastAttitudeTime": "timestamp",
                     "AHRSStatus": "status"
            ]}

        
//        enum StratuxCodingKeys: String, CodingKey
//        {
//            case latitude = "GPSLatitude"
//            case longitude = "GPSLongitude"
//        }
    }
}
