//
//  Constants.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/30/18.
//

import Foundation

extension IADSB {
    public struct Constants {
        static let metersPerNM = 1852.0
        static func nm(meters:Double) -> Double {
            return (round(meters/metersPerNM))
        }
        static let metersPerKnot = metersPerNM/3600.0 // meters/second -> nm/hour
        
        static func knots(metersPerSecond:Double) -> Double {
            return metersPerSecond / metersPerKnot
        }
        static func metersPerSecond(knots:Double) -> Double {
            return knots * metersPerKnot
        }
        static func metersPerSecondNil(knots:Double?) -> Double? {
            guard let knots = knots else { return nil }
            return metersPerSecond(knots:knots)
        }
        static let nmPerDegree = 60.0
        static func nm(degrees:Double) -> Double {
            return (degrees/nmPerDegree)
        }
        static func feet(nm:Double) -> Double {
            return (nm * 6076.12)
        }
        static func nm(feet:Double) -> Double {
            return (feet / 6076.12)
        }
        
        static let feetPerMeter = 3.28084
        static func feet(meters:Double) -> Double {
            return meters * feetPerMeter
        }
        static func meters(feet:Double) -> Double {
            return feet / feetPerMeter
        }
        static func metersNil(feet:Double?) -> Double? {
            guard let feet = feet else { return nil }
            return meters(feet: feet)
        }
        static func feetPerMinute(metersPerSecond:Double) -> Double {
            return feet(meters: metersPerSecond) * 60.0
        }
        static func metersPerSecond(feetPerMinute:Double) -> Double {
            return meters(feet: feetPerMinute) / 60.0
        }
        static func metersPerSecondNil(feetPerMinute:Double?) -> Double? {
            guard let feetPerMinute = feetPerMinute else { return nil }
            return metersPerSecond(feetPerMinute: feetPerMinute)
        }
        
        static func farenheit(celsius:Double) -> Double {
            return celsius * 9.0/5.0 + 32.0
        }
    }
}
