//
//  Declination.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/9/18.
//

import Foundation
import ObjectiveWMM

public struct Declination {
    
    public static func at(location:CLLocation) -> Double {
        return ObjectiveWMM.declination(location: location)
    }
    
    public static func at(coordinate:CLLocationCoordinate2D, elevation:Double? = nil, date:Date? = nil) -> Double {
        return ObjectiveWMM.declination(coordinate:coordinate, elevation: elevation ?? 0.0, date: date);
    }
}
