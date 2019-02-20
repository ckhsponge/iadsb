//
//  DeviceNetwork.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/6/18.
//

import Foundation

public class DeviceNetwork: Device {
    public struct Connection {
        public var url:String
        public var types:[ServiceCodable.Type]
        public var subscribeChannel:String?
        init(url:String, types:[ServiceCodable.Type], subscribeChannel:String? = nil) {
            self.url = url
            self.types = types
            self.subscribeChannel = subscribeChannel
        }
        
        init(url:String, type:ServiceCodable.Type) {
            self.init(url:url, types:[type])
        }
    }
    
    public var connections:[Connection] {
        return [Connection]()
    }
    
    override public func start() {
        super.start()
        checkOnce()
    }
    
    override public func stop() {
        super.stop()
    }
    
    public func setServiceFrom(_ type:ServiceCodable.Type, jsonString:String) {
        if let data = jsonString.data(using: .utf8) {
            setServiceFrom(type, data:data)
        }
    }
    
    // Creates a service from the data and stores it
    public func setServiceFrom(_ type:ServiceCodable.Type, data:Data?) {
        add(service:type.createFrom(data: data, device: self))
    }
    
    public func add(service:Service?) {
        switch service {
        case let gps as GPS:
            self.gps = gps
        case let barometer as Barometer:
            self.barometer = barometer
        case let ahrs as AHRS:
            self.ahrs = ahrs
        case let target as Target:
            if traffic == nil {
                traffic = Traffic()
                traffic?.device = self
            }
            traffic?.add(target)
        default: let _ = 0
        }
    }
    
    public func serviceFrom<T>(_ type:T.Type, attributes:[String:Any]) -> T? where T : ServiceCodable {
        print("jsonData \(attributes)")
        let jsonData = try? JSONSerialization.data(withJSONObject: attributes, options: .prettyPrinted)
        return serviceFrom(type, data:jsonData)
    }
    
    public func serviceFrom<T>(_ type:T.Type, jsonString:String) -> T? where T : ServiceCodable {
        print("jsonString \(jsonString)")
        //let data = try? JSONSerialization.data(withJSONObject: jsonString, options: [])
        let data = jsonString.data(using: .utf8)
        return serviceFrom(type, data:data)
    }
    
    public func serviceFrom<T>(_ type:T.Type, data:Data?) -> T? where T : ServiceCodable {
        return type.createFrom(data: data, device: self) as? T
    }

}
