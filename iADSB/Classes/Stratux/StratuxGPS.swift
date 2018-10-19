//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation


//public extension IADSB.Stratux {
//    public class GPS:IADSB.ModelMaker<IADSB.GPS> {
////        var keyMapping:[String:String]? { return  ["latitude":"GPSLatitude", "longitude":"GPSLongitude",
////                          "altitude":"GPSLongitude", "horizontalAccuracy":"GPSHorizontalAccuracy", "verticalAccuracy":"GPSVerticalAccuracy",
////                          "speed":"GPSGroundSpeed", "verticalSpeed":"GPSVerticalSpeed", "courseTrue":"GPSTrueCourse",
////                          "turnRate":"GPSTurnRate", "timestamp":"GPSTime"
////            ]}
//        override public var keyMapping:[String:String] { return  ["GPSLatitude":"latitude", "GPSLongitude":"longitude",
//                                                   "GPSAltitude":"altitude", "GPSHorizontalAccuracy":"horizontalAccuracy", "GPSVerticalAccuracy":"verticalAccuracy",
//                                                   "GPSGroundSpeed":"speed", "GPSVerticalSpeed":"verticalSpeed", "GPSTrueCourse":"courseTrue",
//                                                   "GPSTurnRate":"turnRate", "GPSTime":"timestamp"
//            ]}
//    }
//}

public extension IADSB.Stratux {
    public class GPS: IADSB.GPS {
        override public class var keyMapping:[String:String]? { return  ["GPSLatitude":"latitude", "GPSLongitude":"longitude",
                                                           "GPSAltitudeMSL":"altitude", "GPSHorizontalAccuracy":"horizontalAccuracy", "GPSVerticalAccuracy":"verticalAccuracy",
                                                           "GPSGroundSpeed":"speed", "GPSVerticalSpeed":"verticalSpeed", "GPSTrueCourse":"courseTrue",
                                                           "GPSTurnRate":"turnRate", "GPSTime":"timestamp"
            ]}

        
//        enum StratuxCodingKeys: String, CodingKey
//        {
//            case latitude = "GPSLatitude"
//            case longitude = "GPSLongitude"
//        }
    }
}
