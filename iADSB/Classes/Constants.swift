//
//  Constants.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/30/18.
//

import Foundation

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
    }
}
