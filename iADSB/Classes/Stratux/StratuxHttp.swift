//
//  Stratux.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Stratux {
    public class ProviderHttp: IADSB.ProviderHttp {
        public var urlBase = "http://192.168.10.1/"
        // for testing: "http://localhost:3000/stratux/situation.json"
        
        override public var name:String { return "StratuxH" }
        
        override public var connections:[Connection] {
            return [
                IADSB.ProviderNetwork.Connection(url:"\(urlBase)/getSituation", types:[IADSB.Stratux.GPS.self,IADSB.Stratux.Barometer.self,IADSB.Stratux.AHRS.self]),
                IADSB.ProviderNetwork.Connection(url:"\(urlBase)/getTraffic", type:IADSB.Stratux.Target.self)
            ]
        }
    }
}
