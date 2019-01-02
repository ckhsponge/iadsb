//
//  GPS.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation
import CoreLocation
//
//public extension IADSB {
//    public class Model: Codable {
//        public class var keyMapping:[String:String]? { return nil }
//        public init() {}
//    }
//}

public extension IADSB {
    public class GPS: IADSB.Model,Codable {
        
        public var latitude:Double? = nil
        public var longitude:Double? = nil
        public var altitude:Double? = nil
        public var horizontalAccuracy:Double? = nil
        public var verticalAccuracy:Double? = nil
        public var speed:Double? = nil
        public var verticalSpeed:Double? = nil
        public var courseTrue:Double? = nil
        public var turnRate:Double? = nil
        public var satelliteCount:Int? = nil
        public var timestamp:Date? = nil
        public static var minimumAccuracy:Double = 1000
        static let inaccurate:Double = 99999
        static let untimely:TimeInterval = 5.0 // seconds
        
        override var comparableArray:[Double] {
            return [createdAt.timeIntervalBeforeNow < IADSB.GPS.untimely ? 0 : 1, self.horizontalAccuracy ?? IADSB.GPS.inaccurate, self.verticalAccuracy ?? IADSB.GPS.inaccurate]
        }
        
        public var speedKnots:Double? {
            get { return IADSB.Constants.knots(metersPerSecond: speed) }
            set { speed = IADSB.Constants.metersPerSecond(knots: newValue) }
        }
        
        public var verticalSpeedFPM:Double? {
            return IADSB.Constants.feetPerMinute(metersPerSecond: verticalSpeed);
        }
        
        public var altitudeFeet:Double? {
            guard let altitude = altitude else { return nil }
            return IADSB.Constants.feet(meters:altitude);
        }
        
        public var horizontalAccuracyFeet:Double? {
            return IADSB.Constants.feet(meters:horizontalAccuracy);
        }
        
        public var verticalAccuracyFeet:Double? {
            return IADSB.Constants.feet(meters:verticalAccuracy);
        }
        
        public var courseMagnetic:Double? {
            guard let courseTrue = courseTrue, let declination = magneticDeclination else { return nil }
            return courseTrue - declination
        }
        
        public var magneticDeclination:Double? {
            guard let coordinate = coordinate else { return nil }
            return Declination.at(coordinate: coordinate, elevation: altitude, date: timestamp)
        }
        
        public var description:String {
            return "\(String(describing: location)) -- altitude: \(String(describing: altitude)), VS: \(String(describing: verticalSpeed)), turnRate: \(String(describing: turnRate)), accuracy: \(String(describing: horizontalAccuracy))x\(String(describing: verticalAccuracy))"
        }
        
        override public func afterDecode() {
            super.afterDecode()
            nilifyInacurates()
        }
        
        public func nilifyInacurates() {
            if let accuracy = horizontalAccuracy, accuracy < 0.0 || accuracy > IADSB.GPS.minimumAccuracy {
                self.horizontalAccuracy = nil
            }
            if let accuracy = verticalAccuracy, accuracy < 0.0 || accuracy > IADSB.GPS.minimumAccuracy {
                self.verticalAccuracy = nil
            }
            if horizontalAccuracy == nil {
                latitude = nil
                longitude = nil
                courseTrue = nil
                speed = nil
                turnRate = nil
            }
            if verticalAccuracy == nil {
                altitude = nil
                verticalSpeed = nil
            }
        }
        
//        public init() {}

//        required public init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            latitude = try values.decode(Double?.self, forKey: .latitude)
//            longitude = try values.decode(Double?.self, forKey: .longitude)
//        }
//
//        public static func keyType() -> Key.Type {
//            return CodingKeys.self
//        }
        
        
//        enum CodingKeys: String, CodingKey
//        {
//            case latitude = "GPSLatitude"
//            case longitude = "GPSLongitude"
//        }
        
//        public class func from( attributes:[String:Any] ) -> Self {
//            var mapped = [String:Any]()
//            for (key,value) in attributes {
//                mapped[ key ] = value
////                mapped[ keyMapping[key] ?? key ] = value
//            }
//            let jsonData = try? JSONSerialization.data(withJSONObject: mapped, options: .prettyPrinted)
//            let gps = try? JSONDecoder().decode(self, from: jsonData!)
//            return gps!
//        }
    }
}

//public extension IADSB.GPS {
//    var location:CLLocation? = nil
//}

//public extension IADSB {
//    public class GPS {
//        public var latitude:Double? { return nil }
//        public var longitude:Double? { return nil }
//        public var altitude:Double? { return nil }
//        public var horizontalAccuracy:Double? { return nil }
//        public var verticalAccuracy:Double? { return nil }
//        public var speed:Double? { return nil }
//        public var verticalSpeed:Double? { return nil }
//        public var courseTrue:Double? { return nil }
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
