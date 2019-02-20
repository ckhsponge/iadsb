//
//  Stratux.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

// uses HTTP Get requests for retrieving GPS, Barometer and AHRS
public extension Stratux {
    public class DeviceHttp: iADSB.DeviceHttp {
        public var urlBase = "http://192.168.10.1"
        // for testing: "http://localhost:3000/stratux/situation.json"
        
        override public var name:String { return "StratuxH" }
        
        override public var connections:[Connection] {
            return [
                DeviceNetwork.Connection(url:"\(urlBase)/getSituation", types:[Stratux.GPS.self,Stratux.Barometer.self,Stratux.AHRS.self])
                // traffic is not available from http, only websockets
            ]
        }
    }
}
