//
//  Service.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//
// IMPORTANT!!! All data transport extends from this class.

import Foundation

public typealias ServiceCodable = Service & Codable
// This superclass must NOT be Codable, no vars live here
public class Service: Comparable {
    public class var keyMapping:[String:String]? { return nil }
    
    public enum Category: String, CaseIterable {
        case gps, barometer, ahrs, traffic
    }
    
    // services
    public var device:Device?
    
    // when this was instantiated
    public var createdAt:Date = {Date()}()
    
    //
    public var age:TimeInterval { return createdAt.timeIntervalBeforeNow }
    
    // override this to specify how services are sorted
    // defaults to negative of device priority so higher priorities are firt
    var comparableArray:[Double] {
        return [ Double(-1 * devicePriority) ]
    }
    
    required public init() {
    }
    
    public static func < (lhs: Service, rhs: Service) -> Bool {
        return lhs.lessThan( rhs )
    }
    public func lessThan(_ rhs: Service) -> Bool {
        return comparableArray.lexicographicallyPrecedes(rhs.comparableArray) || self.deviceName < rhs.deviceName
    }
    
    public static func == (lhs: Service, rhs: Service) -> Bool {
        return lhs.isEqual(rhs)
    }
    public func isEqual(_ rhs: Service) -> Bool {
        return comparableArray == rhs.comparableArray && self.deviceName == rhs.deviceName
    }
    
    public var deviceName:String {
        return device?.name ?? ""
    }
    
    public var devicePriority:Int {
        return device?.priority ?? 0
    }
    
    func nilifyOldDates() {
        // TODO set 1970 dates to nil
    }
    
    func afterDecode() {
        nilifyOldDates()
    }
    
    class func createFrom(data:Data?, device:Device) -> ServiceCodable? {
        return nil
    }
}

