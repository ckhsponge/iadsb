//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Stratux {
    public class Barometer: IADSB.Barometer {
        override public class var keyMapping:[String:String]? { return  ["BaroTemperature": "temperature",
                                                                         "BaroPressureAltitude": "pressureAltitude",
                                                                         "BaroVerticalSpeed": "verticalSpeed",
                                                                         "BaroLastMeasurementTime": "timestamp"
            ]}

        override public func afterDecode() {
            super.afterDecode()
            if let altitude = self.pressureAltitude {
                self.pressureAltitude = IADSB.Constants.meters(feet: altitude)
            }
        }
        
//        enum StratuxCodingKeys: String, CodingKey
//        {
//            case latitude = "GPSLatitude"
//            case longitude = "GPSLongitude"
//        }
    }
}
