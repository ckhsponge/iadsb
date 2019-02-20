//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension Stratux {
    public class GPS: iADSB.GPS {
        override public class var keyMapping:[String:String]? { return  ["GPSLatitude":"latitude", "GPSLongitude":"longitude",
                                                           "GPSAltitudeMSL":"altitude", "GPSHorizontalAccuracy":"horizontalAccuracy", "GPSVerticalAccuracy":"verticalAccuracy",
                                                           "GPSGroundSpeed":"speed", "GPSVerticalSpeed":"verticalSpeed", "GPSTrueCourse":"courseTrue",
                                                           "GPSTurnRate":"turnRate", "GPSSatellites":"satelliteCount", "GPSTime":"timestamp"
            ]}

        override public func afterDecode() {
            super.afterDecode()
            self.horizontalAccuracy = Constants.meters(feet: horizontalAccuracy)
            self.verticalAccuracy = Constants.meters(feet: verticalAccuracy)
            self.speed = Constants.metersPerSecond(knots: speed)
            self.altitude = Constants.meters(feet: altitude)
            self.verticalSpeed = Constants.metersPerSecond(feetPerMinute: self.verticalSpeed)
            // turn rate units? minutesPerTurn -> degreesPerSecond
        }
        
    }
}
