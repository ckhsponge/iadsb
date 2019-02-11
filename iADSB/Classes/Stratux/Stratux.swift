//
//  Stratux.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/10/19.
//

import Foundation

public extension IADSB.Stratux {
    public class Device: IADSB.DeviceWebSocket {
        let urlBase = "ws://localhost:3000"
        
        override public var name:String { return "Stratux" }
        
        override public var connections:[Connection] {
            return [
                IADSB.DeviceNetwork.Connection(url:"\(urlBase)/situation", types:[IADSB.Stratux.GPS.self,IADSB.Stratux.Barometer.self,IADSB.Stratux.AHRS.self]),
                IADSB.DeviceNetwork.Connection(url:"\(urlBase)/traffic", type:IADSB.Stratux.Target.self)
            ]
        }
    }
}

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
