//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension Stratux {
    public class Barometer: iADSB.Barometer {
        override public class var keyMapping:[String:String]? { return  ["BaroTemperature": "temperature",
                                                                         "BaroPressureAltitude": "pressureAltitude",
                                                                         "BaroVerticalSpeed": "verticalSpeed",
                                                                         "BaroLastMeasurementTime": "timestamp"
            ]}

        override public func afterDecode() {
            super.afterDecode()
            self.pressureAltitude = Constants.meters(feet: pressureAltitude)
            self.verticalSpeed = Constants.metersPerSecond(feetPerMinute: verticalSpeed)
        }
        
//        enum StratuxCodingKeys: String, CodingKey
//        {
//            case latitude = "GPSLatitude"
//            case longitude = "GPSLongitude"
//        }
    }
}
