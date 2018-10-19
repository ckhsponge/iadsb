//
//  Provider.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB {
    public class Provider {
        var manager:Manager
        public init( _ manager:Manager ) {
            self.manager = manager
        }
        public func start() {
            
        }
        public var gps:IADSB.GPS? = nil
        public var ahrs:IADSB.AHRS? = nil
        public var barometer:IADSB.Barometer? = nil
    }
}
