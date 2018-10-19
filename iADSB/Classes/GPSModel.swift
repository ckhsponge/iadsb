//
//  GPSModel.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/12/18.
//

import Foundation
import CoreLocation

//public extension IADSB {
//    public class GPSModel: Model, IADSBGPS {
//        public var latitude:Double? { return doubleFrom( key: "latitude" ) }
//        public var longitude:Double? { return doubleFrom( key: "longitude" ) }
//        public var altitude:Double? { return doubleFrom( key: "altitude" ) }
//        public var horizontalAccuracy:Double? { return doubleFrom( key: "horizontalAccuracy" ) }
//        public var verticalAccuracy:Double? { return doubleFrom( key: "verticalAccuracy" ) }
//        public var speed:Double? { return doubleFrom( key: "speed" ) }
//        public var verticalSpeed:Double? { return doubleFrom( key: "verticalSpeed" ) }
//        public var courseTrue:Double? { return doubleFrom( key: "courseTrue" ) }
//        public var turnRate:Double? { return doubleFrom( key: "turnRate" ) }
//        public var timestamp:Date? { return dateFrom( key: "timestamp" ) }
//        public var location:CLLocation? {
//            if let latitude = self.latitude, let longitude = self.longitude {
//                if let altitude = self.altitude, let horizontalAccuracy = self.horizontalAccuracy,
//                    let verticalAccuracy = self.verticalAccuracy {
//                    if let course = self.courseTrue, let speed = self.speed {
//                        return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, course: course, speed: speed, timestamp: Date())
//                    }
//                    return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
//                                      altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, timestamp: Date())
//                }
//                return CLLocation(latitude: latitude, longitude: longitude)
//            }
//            return nil
//        }
//        
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
