//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Stratux {
    public class GPS: IADSB.GPS {
        override public class var keyMapping:[String:String]? { return  ["GPSLatitude":"latitude", "GPSLongitude":"longitude",
                                                           "GPSAltitudeMSL":"altitude", "GPSHorizontalAccuracy":"horizontalAccuracy", "GPSVerticalAccuracy":"verticalAccuracy",
                                                           "GPSGroundSpeed":"speed", "GPSVerticalSpeed":"verticalSpeed", "GPSTrueCourse":"courseTrue",
                                                           "GPSTurnRate":"turnRate", "GPSSatellites":"satelliteCount", "GPSTime":"timestamp"
            ]}

        override public func afterDecode() {
            super.afterDecode()
            self.horizontalAccuracy = IADSB.Constants.meters(feet: horizontalAccuracy)
            self.verticalAccuracy = IADSB.Constants.meters(feet: verticalAccuracy)
            self.speed = IADSB.Constants.metersPerSecond(knots: speed)
            self.altitude = IADSB.Constants.meters(feet: altitude)
            self.verticalSpeed = IADSB.Constants.metersPerSecond(feetPerMinute: self.verticalSpeed)
            // turn rate units? minutesPerTurn -> degreesPerSecond
        }
        
    }
}
