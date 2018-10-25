//
//  GPSLocation.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/12/18.
//

import Foundation
import CoreLocation

public extension IADSB.GPS {
    convenience init( location:CLLocation, previousGPS:IADSB.GPS? = nil, provider:IADSB.Provider ) {
        self.init()
        self.provider = provider
        horizontalAccuracy = positiveOrNil(location.horizontalAccuracy)
        verticalAccuracy = positiveOrNil(location.verticalAccuracy)
        latitude = horizontalAccuracy == nil ? nil : location.coordinate.latitude
        longitude = horizontalAccuracy == nil ? nil : location.coordinate.longitude
        altitude = verticalAccuracy == nil ? nil : location.altitude
        speed = positiveOrNil(location.speed)
        courseTrue = positiveOrNil(location.course)
        timestamp = location.timestamp
        verticalSpeed = verticalSpeedFrom( previousGPS:previousGPS )
        turnRate = turnRate( previousGPS:previousGPS )
    }
    
    func verticalSpeedFrom( previousGPS:IADSB.GPS? ) -> Double? {
        guard let previousGPS = previousGPS,
            let h1 = self.altitude, let h2 = previousGPS.altitude,
            let t1 = self.timestamp, let t2 = previousGPS.timestamp else {
                return nil
        }
        return (h1 - h2) / (t2.timeIntervalSince(t1))
    }
    
    func turnRate( previousGPS:IADSB.GPS? ) -> Double? {
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
    
    public var location:CLLocation? {
        if let latitude = self.latitude, let longitude = self.longitude {
            if let altitude = self.altitude, let horizontalAccuracy = self.horizontalAccuracy,
                let verticalAccuracy = self.verticalAccuracy {
                if let course = self.courseTrue, let speed = self.speed {
                    return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, course: course, speed: speed, timestamp: self.timestamp ?? Date())
                }
                return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                  altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, timestamp: self.timestamp ?? Date())
            }
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        return nil
    }
}
