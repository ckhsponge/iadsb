//
//  Model.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//
// IMPORTANT!!! All data transport extends from this class.

import Foundation

public struct IADSB {
    public typealias ModelCodable = Model & Codable
    // This superclass must NOT be Codable, no vars live here
    public class Model: Comparable {
        public class var keyMapping:[String:String]? { return nil }
        
        public enum Service: String, CaseIterable {
            case gps, barometer, ahrs, traffic
        }
        
        // models 
        public var provider:IADSB.Provider?
        
        // when this model was instantiated
        public var createdAt:Date = {Date()}()
        
        //
        public var age:TimeInterval { return createdAt.timeIntervalBeforeNow }
        
        // override this to specify how models are sorted
        // defaults to negative of provider priority so higher priorities are firt
        var comparableArray:[Double] {
            return [ Double(-1 * providerPriority) ]
        }
        
        required public init() {
        }
        
        public static func < (lhs: IADSB.Model, rhs: IADSB.Model) -> Bool {
            return lhs.lessThan( rhs )
        }
        public func lessThan(_ rhs: IADSB.Model) -> Bool {
            return comparableArray.lexicographicallyPrecedes(rhs.comparableArray) || self.providerName < rhs.providerName
        }
        
        public static func == (lhs: IADSB.Model, rhs: IADSB.Model) -> Bool {
            return lhs.isEqual(rhs)
        }
        public func isEqual(_ rhs: IADSB.Model) -> Bool {
            return comparableArray == rhs.comparableArray && self.providerName == rhs.providerName
        }
        
        public var providerName:String {
            return provider?.name ?? ""
        }
        
        public var providerPriority:Int {
            return provider?.priority ?? 0
        }
        
        func nilifyOldDates() {
            // TODO set 1970 dates to nil
        }
        
        func afterDecode() {
            nilifyOldDates()
        }
        
        class func createFrom(data:Data?, provider:Provider) -> ModelCodable? {
            return nil
        }
    }
}

//public extension IADSB {
//    public extension Model {
//        func createIt(data:Data, provider:Provider) -> ModelCodable? {
//            return nil
//        }
//    }
//}

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
