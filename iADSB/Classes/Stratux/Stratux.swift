//
//  Stratux.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Stratux {
    public class Provider: IADSB.ProviderNetwork {
//        let url = "http://192.168.10.1/getSituation"
        let url = "http://localhost:3000/stratux.json"
        
        override public var name:String { return "Stratux" }
        
        override public func checkOnce() {
            dataFrom(url: url) { (data) in
                self.setModelFrom(IADSB.Stratux.GPS.self, data: data)
                self.setModelFrom(IADSB.Stratux.Barometer.self, data: data)
                self.setModelFrom(IADSB.Stratux.AHRS.self, data: data)
                self.manager.update(provider: self)
            }
        }
    }
}
