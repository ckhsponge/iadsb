//
//  Network.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation
import Alamofire

public class Network {
    public init() {}
    
    public func go() {
        Alamofire.request("http://localhost:3000/stratux.json").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("class: \(type(of:json))")
                print("JSON: \(json)") // serialized json response
                if let hash = json as? [String : Any] {
                    print("HASH: \(hash)")
                    if let o = hash.first {
                        print("o: \(o)")
                    }
                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
//        public func data() {
//            Alamofire.request("http://localhost:3000/stratux.json").responseData { (response) in
//                print("Request: \(String(describing: response.request))")   // original url request
//                print("Response: \(String(describing: response.response))") // http url response
//                print("Result: \(response.result)")                         // response serialization result
//                
//                if let data = response.data {
//                    let gps = Stratux.GPS.from(Stratux.GPS.self, data: data)
//                    print("Alamo data: \(String(describing: gps.location))")
//                }
//            }
//        }
}

