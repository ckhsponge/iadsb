//
//  ProviderNetwork.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/6/18.
//

import Foundation

public extension IADSB {
    public class ProviderNetwork: IADSB.Provider {
        public struct Connection {
            public var url:String
            public var types:[ModelCodable.Type]
            public var subscribeChannel:String?
            init(url:String, types:[ModelCodable.Type], subscribeChannel:String? = nil) {
                self.url = url
                self.types = types
                self.subscribeChannel = subscribeChannel
            }
            
            init(url:String, type:ModelCodable.Type) {
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
        
        public func setModelFrom(_ type:ModelCodable.Type, jsonString:String) {
            if let data = jsonString.data(using: .utf8) {
                setModelFrom(type, data:data)
            }
        }
        
        // Creates a model from the data and stores it
        public func setModelFrom(_ type:ModelCodable.Type, data:Data?) {
            add(model:type.createFrom(data: data, provider: self))
        }
        
        public func add(model:IADSB.Model?) {
            switch model {
            case let gps as IADSB.GPS:
                self.gps = gps
            case let barometer as IADSB.Barometer:
                self.barometer = barometer
            case let ahrs as IADSB.AHRS:
                self.ahrs = ahrs
            case let target as IADSB.Target:
                if traffic == nil {
                    traffic = IADSB.Traffic()
                    traffic?.provider = self
                }
                traffic?.add(target)
            default: let _ = 0
            }
        }
        
        public func modelFrom<T>(_ type:T.Type, attributes:[String:Any]) -> T? where T : ModelCodable {
            print("jsonData \(attributes)")
            let jsonData = try? JSONSerialization.data(withJSONObject: attributes, options: .prettyPrinted)
            return modelFrom(type, data:jsonData)
        }
        
        public func modelFrom<T>(_ type:T.Type, jsonString:String) -> T? where T : ModelCodable {
            print("jsonString \(jsonString)")
            //let data = try? JSONSerialization.data(withJSONObject: jsonString, options: [])
            let data = jsonString.data(using: .utf8)
            return modelFrom(type, data:data)
        }
        
        public func modelFrom<T>(_ type:T.Type, data:Data?) -> T? where T : ModelCodable {
            return type.createFrom(data: data, provider: self) as? T
        }

    }
}
