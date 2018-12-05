//
//  Model.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Model {
    
    public var providerName:String { return provider?.name ?? ""}
    
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
