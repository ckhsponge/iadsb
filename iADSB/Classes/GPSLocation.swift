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
        public var latitude:Double? { return positiveOrNil(locationStored.coordinate.latitude) }
        public var longitude:Double? { return positiveOrNil(locationStored.coordinate.longitude) }
        public var altitude:Double? { return positiveOrNil(locationStored.altitude) }
        public var horizontalAccuracy:Double? { return positiveOrNil(locationStored.horizontalAccuracy) }
        public var verticalAccuracy:Double? { return positiveOrNil(locationStored.verticalAccuracy) }
        public var speed:Double? { return positiveOrNil(locationStored.speed) }
        public var verticalSpeed:Double? { return nil }
        public var trueCourse:Double? { return positiveOrNil(locationStored.course) }
        public var turnRate:Double? { return nil }
        public var location:CLLocation? { return locationStored }
        var locationStored:CLLocation
//        override public var location: CLLocation? { return self.location }
        init( location:CLLocation ) {
            self.locationStored = location
        }
        
        func positiveOrNil(_ double:Double? ) -> Double? {
            if let double = double, double >= 0.0 {
                return double
            }
            return nil
        }
    }
}
