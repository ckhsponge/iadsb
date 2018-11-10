//
//  Provider.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation
import Alamofire

public extension IADSB {
    public class Provider {
        public var gps:IADSB.GPS? = nil
        public var ahrs:IADSB.AHRS? = nil
        public var barometer:IADSB.Barometer? = nil
        var manager:Manager
        
        public init( _ manager:Manager ) {
            self.manager = manager
        }
        
        public func start() {
            
        }
        
        public func checkOnce() {
            
        }
        
        public var name:String { return "UNDEFINED" }
    }
}
