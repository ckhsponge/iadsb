//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation
import CoreLocation

public protocol IADSBGPS {
    var latitude:Double? { get }
    var longitude:Double? { get }
    var altitude:Double? { get }
    var horizontalAccuracy:Double? { get }
    var verticalAccuracy:Double? { get }
    var speed:Double? { get }
    var verticalSpeed:Double? { get }
    var trueCourse:Double? { get }
    var turnRate:Double? { get }
    var location:CLLocation? { get }
}

public extension IADSBGPS {
    public var verticalSpeedFPM:Double? {
        if let vs = verticalSpeed {
            return vs * 1000.0;
        }
        return nil
    }
}

//public extension IADSB {
//    public class GPS {
//        public var latitude:Double? { return nil }
//        public var longitude:Double? { return nil }
//        public var altitude:Double? { return nil }
//        public var horizontalAccuracy:Double? { return nil }
//        public var verticalAccuracy:Double? { return nil }
//        public var speed:Double? { return nil }
//        public var verticalSpeed:Double? { return nil }
//        public var trueCourse:Double? { return nil }
//        public var turnRate:Double? { return nil }
//        public var location:CLLocation? { return nil }
//    }
//}


//"GPSLastFixSinceMidnightUTC": 78047.7,
//"GPSLatitude": 0,
//"GPSLongitude": 0,
//"GPSFixQuality": 0,
//"GPSHeightAboveEllipsoid": 0,
//"GPSGeoidSep": 0,
//"GPSSatellites": 0,
//"GPSSatellitesTracked": 0,
//"GPSSatellitesSeen": 2,
//"GPSHorizontalAccuracy": 999999,
//"GPSNACp": 0,
//"GPSAltitudeMSL": 0,
//"GPSVerticalAccuracy": 999999,
//"GPSVerticalSpeed": 0,
//"GPSLastFixLocalTime": "0001-01-01T00:00:00Z",
//"GPSTrueCourse": 0,
//"GPSTurnRate": 0,
//"GPSGroundSpeed": 0,
//"GPSLastGroundTrackTime": "0001-01-01T00:00:00Z",
//"GPSTime": "2018-10-11T21:40:47.7Z",
//"GPSLastGPSTimeStratuxTime": "0001-01-01T00:24:42.17Z",
//"GPSLastValidNMEAMessageTime": "0001-01-01T00:24:42.17Z",
//"GPSLastValidNMEAMessage": "$PUBX,04,214047.70,111018,423647.69,2022,16D,-32831247,0.000,21*78",
//"GPSPositionSampleRate": 0,
