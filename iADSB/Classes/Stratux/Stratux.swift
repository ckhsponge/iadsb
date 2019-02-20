//
//  Stratux.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/10/19.
//

import Foundation

// uses websockets for retrieving GPS, Barometer and AHRS and Traffic
public struct Stratux {
    public class Device: iADSB.DeviceWebSocket {
        let urlBase = "ws://192.168.10.1"
        
        override public var name:String { return "Stratux" }
        
        override public var connections:[Connection] {
            return [
                DeviceNetwork.Connection(url:"\(urlBase)/situation", types:[Stratux.GPS.self,Stratux.Barometer.self,Stratux.AHRS.self]),
                DeviceNetwork.Connection(url:"\(urlBase)/traffic", type:Stratux.Target.self)
            ]
        }
    }
}
