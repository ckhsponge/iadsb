//
//  ProviderNetwork.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/6/18.
//

import Foundation

public extension IADSB {
    public class ProviderNetwork: IADSB.Provider {
        
        public var urlTypes:[String:[ModelCodable.Type]] {
            return [String:[ModelCodable.Type]]()
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
        public func setModelFrom(_ type:ModelCodable.Type, data:Data) {
            let model = type.createFrom(data: data, provider: self)
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
        
        public func add(model:IADSB.Model?) {
            guard let model = model else { return }
            
            if let gps = model as? IADSB.GPS {
                self.gps = gps
            } else if let barometer = model as? IADSB.Barometer {
                self.barometer = barometer
            } else if let ahrs = model as? IADSB.AHRS {
                self.ahrs = ahrs
            }
        }
        
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
        
        public func modelFrom<T>(_ type:T.Type, attributes:[String:Any]) -> T? where T : ModelCodable {
            print("jsonData \(attributes)")
            let jsonData = try? JSONSerialization.data(withJSONObject: attributes, options: .prettyPrinted)
            return modelFrom(T.self, data: jsonData!)
        }
        
        public func modelFrom<T>(_ type:T.Type, jsonString:String) -> T? where T : ModelCodable {
            print("jsonString \(jsonString)")
            //let data = try? JSONSerialization.data(withJSONObject: jsonString, options: [])
            let data = jsonString.data(using: .utf8)
            return modelFrom(T.self, data: data ?? Data())
        }
        
        // uses keyMapping from subclass to create an instance
        public func modelFrom<T>(_ type:T.Type, data:Data) -> T? where T : ModelCodable {
            let decoder = JSONDecoder()
            //            if let keyMapping = T.keyMapping {
            if let keyMapping = T.keyMapping {
                print("got mapping \(keyMapping.count)")
                var i = 0
                decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.custom({ (keys) -> CodingKey in
                    i += 1
                    if let key = keys.last {
                        //print( "key \(key.stringValue)")
                        //                StratuxCodingKeys.latitude.r
                        //StratuxCodingKeys.init(stringValue: key.stringValue).
                        if let mapped = keyMapping[key.stringValue] {
                            print( "mapped \(mapped) \(key)")
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
                let model = try decoder.decode(T.self, from: data)
                model.provider = self
                model.afterDecode()
                return model
            } catch {
                print("DECODE ERROR \(error)")
            }
            return nil
        }
    }
}
