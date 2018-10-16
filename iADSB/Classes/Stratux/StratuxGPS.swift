//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation


public extension IADSB.Stratux {
    public class GPS: IADSB.GPSModel {
        override var keyMapping:[String:String]? { return  ["latitude":"GPSLatitude", "longitude":"GPSLongitude",
                          "altitude":"GPSLongitude", "horizontalAccuracy":"GPSHorizontalAccuracy", "verticalAccuracy":"GPSVerticalAccuracy",
                          "speed":"GPSGroundSpeed", "verticalSpeed":"GPSVerticalSpeed", "trueCourse":"GPSTrueCourse",
                          "turnRate":"GPSTurnRate"
            ]}
    }
}
