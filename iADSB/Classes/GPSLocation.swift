//
//  GPSLocation.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/12/18.
//

import Foundation
import CoreLocation

public extension IADSB.GPS {
    convenience init( location:CLLocation, previousGPS:IADSB.GPS? = nil, device:IADSB.Device ) {
        self.init()
        self.device = device
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
        return (h2 - h1) / (t2.timeIntervalSince(t1))
    }
    
    func turnRate( previousGPS:IADSB.GPS? ) -> Double? {
        guard let previousGPS = previousGPS,
            let c1 = self.courseTrue, let c2 = previousGPS.courseTrue,
            let t1 = self.timestamp, let t2 = previousGPS.timestamp else {
                return nil
        }
        return (c2 - c1) / (t2.timeIntervalSince(t1))
    }
    
    func positiveOrNil(_ double:Double? ) -> Double? {
        if let double = double, double >= 0.0 {
            return double
        }
        return nil
    }
    
    public var coordinate:CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var location:CLLocation? {
        return IADSB.GPS.location(latitude:latitude, longitude:longitude, horizontalAccuracy:horizontalAccuracy, verticalAccuracy:verticalAccuracy, altitude:altitude, courseTrue:courseTrue, speed:speed , timestamp:timestamp)
    }
    
    public class func location(latitude:Double?, longitude:Double?, horizontalAccuracy:Double?, verticalAccuracy:Double?, altitude:Double?, courseTrue:Double?, speed:Double? , timestamp:Date?) -> CLLocation? {
        let horizontalAccuracy = horizontalAccuracy ?? -1.0
        let verticalAccuracy = verticalAccuracy ?? -1.0
        if let latitude = latitude, let longitude = longitude {
            if let altitude = altitude {
                if let course = courseTrue, let speed = speed {
                    return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, course: course, speed: speed, timestamp: timestamp ?? Date())
                }
                return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                  altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, timestamp: timestamp ?? Date())
            }
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        return nil
    }
}
