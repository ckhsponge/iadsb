//
//  Declination.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/9/18.
//

import Foundation
import ObjectiveWMM

extension IADSB {
    public struct Declination {
        static var model:CCMagneticModel = CCMagneticModel()
        
        public static func at(location:CLLocation) -> Double {
            return CCMagneticModel.declination(for: location)
        }
        
        public static func at(latitude:Double, longitude:Double, elevation:Double? = nil, date:Date? = nil) -> Double {
            if let declination = model.declination(for: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), elevation: elevation ?? 0.0, date: date ?? Date()) {
                return declination.magneticDeclination
            }
            return 0.0
        }
    }
}
