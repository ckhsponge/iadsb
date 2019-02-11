//
//  Delegate.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/12/18.
//

import Foundation

public protocol IADSBDelegate {
    func update(manager:IADSB.Manager, device:IADSB.Device )
}

public protocol IADSBDelegateInactive: IADSBDelegate {
    func iadsbInactive()
}
