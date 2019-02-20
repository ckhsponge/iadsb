//
//  Stratux.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/10/19.
//

import Foundation

// uses websockets for retrieving GPS, Barometer and AHRS and Traffic
public extension IADSB.Stratux {
    public class Device: IADSB.DeviceWebSocket {
        let urlBase = "ws://192.168.10.1"
        
        override public var name:String { return "Stratux" }
        
        override public var connections:[Connection] {
            return [
                IADSB.DeviceNetwork.Connection(url:"\(urlBase)/situation", types:[IADSB.Stratux.GPS.self,IADSB.Stratux.Barometer.self,IADSB.Stratux.AHRS.self]),
                IADSB.DeviceNetwork.Connection(url:"\(urlBase)/traffic", type:IADSB.Stratux.Target.self)
            ]
        }
    }
}
