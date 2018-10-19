//
//  Model.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Model {
    struct AnyKey: CodingKey {
        public var stringValue: String
        public var intValue: Int?
        
        public init(stringValue: String) {
            self.stringValue = stringValue
        }
        
        public init(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }
    
    public class func from<T>( _ type:T.Type, attributes:[String:Any] ) -> T where T : IADSB.Model & Codable {
        print("jsonData \(attributes)")
        let jsonData = try? JSONSerialization.data(withJSONObject: attributes, options: .prettyPrinted)
        return from( T.self, data: jsonData!)
    }
    
    public class func from<T>( _ type:T.Type, data:Data ) -> T where T : IADSB.Model & Codable {
        let decoder = JSONDecoder()
        //            if let keyMapping = T.keyMapping {
        if let keyMapping = T.keyMapping {
            print("got mapping \(keyMapping.count)")
            var i = 0
            decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.custom({ (keys) -> CodingKey in
                i += 1
                if let key = keys.last {
                    print( "key \(key.stringValue)")
                    //                StratuxCodingKeys.latitude.r
                    //StratuxCodingKeys.init(stringValue: key.stringValue).
                    if let mapped = keyMapping[key.stringValue] {
                        print( "mapped \(mapped)")
                        return AnyKey(stringValue: mapped )
                    }
                }
                return AnyKey(stringValue: "")
            })
        }
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            return Date(timeIntervalSince1970: 0)
        })
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("DECODE ERROR \(error)")
        }
        return T()
    }
    
    public func nilifyOldDates() {
        // TODO set 1970 dates to nil
    }
}

//public extension IADSB {
//    public class Model: Codable {
//        public class var keyMapping:[String:String]? { return nil }
//        public init() {}
//    }
//}
//public extension IADSB {
//    public class Model {
//        public var attributes:[String:Any]
//        var keyMapping:[String:String]? { return nil }
//
//        public init( attributes:[String:Any] ) {
//            self.attributes = attributes
//        }
//
//        func anyFrom( key:String ) -> Any? {
//            if let keyMapping = keyMapping, let mappedKey = keyMapping[ key ] {
//                return attributes[ mappedKey ]
//            } else {
//                return attributes[ key ]
//            }
//        }
//
//        func intFrom( key:String ) -> Int? {
//            if let d = anyFrom( key: key ) as? Int {
//                return d
//            }
//            return nil
//        }
//
//        func doubleFrom( key:String ) -> Double? {
//            NSLog("doubleFrom \(key)")
//            if let d = anyFrom( key: key ) as? Double {
//                return d
//            }
//            return nil
//        }
//
//        func stringFrom( key:String ) -> String? {
//            if let a = anyFrom( key: key ) {
//                return String(describing: a)
//            }
//            return nil
//        }
//
//        func dateFrom( key:String ) -> Date? {
//            return nil
//        }
//    }
//}
