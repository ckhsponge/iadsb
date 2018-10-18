//
//  GPSLocation.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/12/18.
//

import Foundation
import CoreLocation

public extension IADSB {
    public class GPSLocation: IADSBGPS {
        public var latitude:Double? { return positiveOrNil(location?.coordinate.latitude) }
        public var longitude:Double? { return positiveOrNil(location?.coordinate.longitude) }
        public var altitude:Double? { return positiveOrNil(location?.altitude) }
        public var horizontalAccuracy:Double? { return positiveOrNil(location?.horizontalAccuracy) }
        public var verticalAccuracy:Double? { return positiveOrNil(location?.verticalAccuracy) }
        public var speed:Double? { return positiveOrNil(location?.speed) }
        public var courseTrue:Double? { return positiveOrNil(location?.course) }
        public var timestamp:Date? { return location?.timestamp }
        public var location:CLLocation?
        var previousGPS:IADSBGPS?
//        override public var location: CLLocation? { return self.location }
        init( location:CLLocation ) {
            self.location = location
        }
        convenience init( location:CLLocation, previousGPS:IADSBGPS? ) {
            self.init(location: location)
            self.previousGPS = previousGPS
        }
        
        public var verticalSpeed:Double? {
            guard let previousGPS = previousGPS,
                let h1 = self.altitude, let h2 = previousGPS.altitude,
                let t1 = self.timestamp, let t2 = previousGPS.timestamp else {
                    return nil
            }
            return (h1 - h2) / (t2.timeIntervalSince(t1))
        }
        
        public var turnRate:Double? {
            guard let previousGPS = previousGPS,
                let c1 = self.courseTrue, let c2 = previousGPS.courseTrue,
                let t1 = self.timestamp, let t2 = previousGPS.timestamp else {
                    return nil
            }
            return (c1 - c2) / (t2.timeIntervalSince(t1))
        }
        
        func positiveOrNil(_ double:Double? ) -> Double? {
            if let double = double, double >= 0.0 {
                return double
            }
            return nil
        }
    }
}
