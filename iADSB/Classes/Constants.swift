//
//  Constants.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/30/18.
//

import Foundation
import CoreLocation
import ObjectiveWMM

extension IADSB {
    public struct Constants {
        public static let metersPerNM = 1852.0
        public static let metersPerKnot = metersPerNM/3600.0 // meters/second -> nm/hour
        public static let nmPerDegree = 60.0
        public static let feetPerMeter = 3.28084
        
        public struct Nonnull {
            public static func nm(meters:Double) -> Double {
                return meters/metersPerNM
            }
            public static func knots(metersPerSecond:Double) -> Double {
                return metersPerSecond / metersPerKnot
            }
            public static func metersPerSecond(knots:Double) -> Double {
                return knots * metersPerKnot
            }
            public static func nm(degrees:Double) -> Double {
                return (degrees/nmPerDegree)
            }
            public static func feet(nm:Double) -> Double {
                return (nm * 6076.12)
            }
            public static func nm(feet:Double) -> Double {
                return (feet / 6076.12)
            }
            public static func feet(meters:Double) -> Double {
                return meters * feetPerMeter
            }
            public static func meters(feet:Double) -> Double {
                return feet / feetPerMeter
            }
            public static func feetPerMinute(metersPerSecond:Double) -> Double {
                return feet(meters: metersPerSecond) * 60.0
            }
            public static func metersPerSecond(feetPerMinute:Double) -> Double {
                return meters(feet: feetPerMinute) / 60.0
            }
            public static func farenheit(celsius:Double) -> Double {
                return celsius * 9.0/5.0 + 32.0
            }
            public static func radians(degrees:Double) -> Double {
                return degrees * Double.pi / 180.0
            }
            public static func degrees(radians:Double) -> Double {
                return radians * 180.0 / Double.pi
            }
            public static func withinZeroTo360(_ degrees:Double) -> Double {
                let f = floor(degrees / 360.0)
                let r = (degrees - (360.0 * f))
                return r
            }
            public static func headingTrue(from:CLLocation, to:CLLocation) -> Double {
                //ATAN2(COS(lat1)*SIN(lat2)-SIN(lat1)*COS(lat2)*COS(lon2-lon1), SIN(lon2-lon1)*COS(lat2))
                var lat1:Double = from.coordinate.latitude
                var lon1:Double = from.coordinate.longitude
                var lat2:Double = to.coordinate.latitude
                var lon2:Double = to.coordinate.longitude
                let dlon:Double = radians(degrees:lon2 - lon1)
                lat1 = radians(degrees:lat1)
                lon1 = radians(degrees:lon1)
                lat2 = radians(degrees:lat2)
                lon2 = radians(degrees:lon2)
                let y:Double = sin(dlon) * cos(lat2)
                let x:Double = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dlon)
                let r:Double = atan2(y, x)
                let heading:Double = degrees(radians:r)
                //heading -= [self magneticDeviation];
                return withinZeroTo360(heading)
            }
            public static func headingMagnetic(from:CLLocation, to:CLLocation) -> Double {
                return headingTrue(from:from, to:to) - ObjectiveWMM.declination(location: from)
            }
        }
        
        public static func nm(meters:Double?) -> Double? {
            guard let meters = meters else { return nil }
            return Nonnull.nm(meters: meters)
        }
        public static func knots(metersPerSecond:Double?) -> Double? {
            guard let metersPerSecond = metersPerSecond else { return nil }
            return Nonnull.knots(metersPerSecond: metersPerSecond)
        }
        public static func metersPerSecond(knots:Double?) -> Double? {
            guard let knots = knots else { return nil }
            return Nonnull.metersPerSecond(knots:knots)
        }
        public static func feet(nm:Double?) -> Double? {
            guard let nm = nm else { return nil }
            return Nonnull.feet(nm: nm)
        }
        public static func nm(feet:Double?) -> Double? {
            guard let feet = feet else { return nil }
            return Nonnull.nm(feet: feet)
        }
        public static func feet(meters:Double?) -> Double? {
            guard let meters = meters else { return nil }
            return Nonnull.feet(meters: meters)
        }
        public static func meters(feet:Double?) -> Double? {
            guard let feet = feet else { return nil }
            return Nonnull.meters(feet: feet)
        }
        public static func feetPerMinute(metersPerSecond:Double?) -> Double? {
            guard let metersPerSecond = metersPerSecond else { return nil }
            return Nonnull.feet(meters: metersPerSecond) * 60.0
        }
        public static func metersPerSecond(feetPerMinute:Double?) -> Double? {
            guard let feetPerMinute = feetPerMinute else { return nil }
            return Nonnull.metersPerSecond(feetPerMinute: feetPerMinute)
        }
        public static func farenheit(celsius:Double?) -> Double? {
            guard let celsius = celsius else { return nil }
            return Nonnull.farenheit(celsius: celsius)
        }
        public static func headingTrue(from:CLLocation?, to:CLLocation?) -> Double? {
            guard let from=from, let to=to else { return nil }
            return Nonnull.headingTrue(from:from, to:to)
        }
        public static func headingMagnetic(from:CLLocation?, to:CLLocation?) -> Double? {
            guard let from=from, let to=to else { return nil }
            return Nonnull.headingMagnetic(from:from, to:to)
        }
    }
}
