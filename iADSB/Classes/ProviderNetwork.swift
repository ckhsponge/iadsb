//
//  ProviderNetwork.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/6/18.
//

import Foundation
import Alamofire

public extension IADSB {
    public class ProviderNetwork: IADSB.Provider {
        
        var timer:Timer?
        
        func startTimer() {
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { (timer) in
                    self.checkOnce()
                })
                self.timer?.tolerance = 0.1
            }
        }
        
        override public func start() {
            checkOnce()
            startTimer()
        }
        
        public func setModelFrom<T>(_ type:T.Type, data:Data) where T : IADSB.Model & Codable {
            let model = self.modelFrom(type, data: data)
            if let gps = model as? IADSB.GPS {
                self.gps = gps
            }
            if let barometer = model as? IADSB.Barometer {
                self.barometer = barometer
            }
            if let ahrs = model as? IADSB.AHRS {
                self.ahrs = ahrs
            }
        }
        
        public func dataFrom(url:String, completionHandler: @escaping (Data) -> Void) {
            Alamofire.request(url).responseData { (response) in
                print("Request: \(String(describing: response.request))")   // original url request
                //                print("Response: \(String(describing: response.response))") // http url response
                //                print("Result: \(response.result)")                         // response serialization result
                
                if let data = response.data {
                    completionHandler(data)
                }
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
        
        public func modelFrom<T>(_ type:T.Type, attributes:[String:Any]) -> T? where T : IADSB.Model & Codable {
            print("jsonData \(attributes)")
            let jsonData = try? JSONSerialization.data(withJSONObject: attributes, options: .prettyPrinted)
            return modelFrom(T.self, data: jsonData!)
        }
        
        public func modelFrom<T>(_ type:T.Type, data:Data) -> T? where T : IADSB.Model & Codable {
            let decoder = JSONDecoder()
            //            if let keyMapping = T.keyMapping {
            if let keyMapping = T.keyMapping {
                //print("got mapping \(keyMapping.count)")
                var i = 0
                decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.custom({ (keys) -> CodingKey in
                    i += 1
                    if let key = keys.last {
                        //print( "key \(key.stringValue)")
                        //                StratuxCodingKeys.latitude.r
                        //StratuxCodingKeys.init(stringValue: key.stringValue).
                        if let mapped = keyMapping[key.stringValue] {
                            //print( "mapped \(mapped)")
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
                return model
            } catch {
                print("DECODE ERROR \(error)")
            }
            return nil
        }
    }
}
