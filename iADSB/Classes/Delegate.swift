//
//  Delegate.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/12/18.
//

import Foundation

public protocol IADSBDelegate {
    func update(manager:iADSB.Manager)
}

public protocol IADSBDelegateInactive: IADSBDelegate {
    func iadsbInactive()
}
