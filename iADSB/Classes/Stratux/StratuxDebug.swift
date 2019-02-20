//
//  StratuxDebug.swift
//  iADSB
//
//  Created by Christopher Hobbs on 2/19/19.
//

import Foundation

// websockets that hit a local server for debugging purposes
public extension IADSB.Stratux {
    public class DeviceLocal: IADSB.Stratux.Device {
        let url = "ws://localhost:3000/cable"
        
        override public var name:String { return "StratuxL" }
        
        override public var connections:[Connection] {
            return [
                IADSB.DeviceNetwork.Connection(url:url, types:[IADSB.Stratux.GPS.self,IADSB.Stratux.Barometer.self,IADSB.Stratux.AHRS.self], subscribeChannel:"StratuxSituationChannel"),
                IADSB.DeviceNetwork.Connection(url:url, types:[IADSB.Stratux.Target.self], subscribeChannel:"StratuxTrafficChannel")
            ]
        }
    }
}
