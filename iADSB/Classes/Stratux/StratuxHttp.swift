//
//  Stratux.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Stratux {
    public class ProviderHttp: IADSB.ProviderHttp {
        public var url = "http://192.168.10.1/getSituation"
        // for testing: "http://localhost:3000/stratux/situation.json"
        
        override public var name:String { return "StratuxH" }
        
        override public var urlTypes:[String : [IADSB.ModelCodable.Type]] {
            return [url: [IADSB.Stratux.GPS.self,IADSB.Stratux.Barometer.self,IADSB.Stratux.AHRS.self]]
        }
        
//        override public func checkOnce() {
//            dataFrom(url: url) { (data) in
//                self.setModelFrom(IADSB.Stratux.GPS.self, data: data)
//                self.setModelFrom(IADSB.Stratux.Barometer.self, data: data)
//                self.setModelFrom(IADSB.Stratux.AHRS.self, data: data)
//                self.manager.update(provider: self)
//            }
//        }
    }
}
