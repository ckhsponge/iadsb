//
//  CoreLocationGPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation
import CoreLocation

public extension IADSB.CoreLocation {
    public class GPS {
        public static func create( location:CLLocation, previousGPS: IADSB.GPS? ) -> IADSB.GPS {
            return IADSB.GPS(location: location, previousGPS: previousGPS)
        }
    }
}
