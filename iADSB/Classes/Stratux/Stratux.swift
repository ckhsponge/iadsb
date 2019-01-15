//
//  Stratux.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/10/19.
//

import Foundation

public extension IADSB.Stratux {
    public class Provider: IADSB.ProviderWebSocket {
        override public var defaultUrl:String { return "ws://localhost:3000/stratux_channel" }
    }
}
