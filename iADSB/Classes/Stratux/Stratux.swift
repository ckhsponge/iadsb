//
//  Stratux.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/10/19.
//

import Foundation

public extension IADSB.Stratux {
    public class Provider: IADSB.ProviderWebSocket {
        let urlBase = "ws://localhost:3000"
        
        override public var name:String { return "Stratux" }
        
        override public var urlTypes:[String:[IADSB.ModelCodable.Type]] {
            return [
                "\(urlBase)/cable": [IADSB.Stratux.GPS.self,IADSB.Stratux.Barometer.self,IADSB.Stratux.AHRS.self,IADSB.Stratux.Target.self]
//                "\(urlBase)/situation": [IADSB.Stratux.GPS.self,IADSB.Stratux.Barometer.self,IADSB.Stratux.AHRS.self],
//                "\(urlBase)/traffic":[IADSB.Stratux.Target.self]
            ]
        }
        
    }
}
