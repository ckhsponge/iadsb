//
//  StratuxDebug.swift
//  iADSB
//
//  Created by Christopher Hobbs on 2/19/19.
//

import Foundation

// websockets that hit a local server for debugging purposes
public extension Stratux {
    public class DeviceLocal: Stratux.Device {
        let url = "ws://localhost:3000/cable"
        
        override public var name:String { return "StratuxL" }
        
        override public var connections:[Connection] {
            return [
                DeviceNetwork.Connection(url:url, types:[Stratux.GPS.self,Stratux.Barometer.self,Stratux.AHRS.self], subscribeChannel:"StratuxSituationChannel"),
                DeviceNetwork.Connection(url:url, types:[Stratux.Target.self], subscribeChannel:"StratuxTrafficChannel")
            ]
        }
    }
}
