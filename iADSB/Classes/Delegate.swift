//
//  Delegate.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/12/18.
//

import Foundation

public protocol IADSBDelegate: class {
    func update( gps:IADSBGPS )
}

//public extension IADSBDelegate {
//    public func hash
//}
