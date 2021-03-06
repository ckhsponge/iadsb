//
//  ServiceJson.swift
//  iADSB
//
//  Created by Christopher Hobbs on 2/6/19.
//

import Foundation

// This superclass must NOT be Codable, no vars live here
public class ServiceJson: Service {
    
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
    
    // uses keyMapping from subclass to create an instance
    override public class func createFrom(data:Data?, device:Device) -> ServiceCodable? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        if let keyMapping = self.keyMapping {
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
            let service = try decoderClass(decoder, data:data)
            service?.device = device
            service?.afterDecode()
            return service
            //                }
        } catch {
            print("DECODE ERROR \(error)")
        }
        return nil
    }
    
    public class func decoderClass(_ decoder:JSONDecoder, data:Data) throws -> ServiceCodable? {
        return nil
    }
}

