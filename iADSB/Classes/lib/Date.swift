//
//  Date.swift
//  iADSB
//
//  Created by Christopher Hobbs on 12/18/18.
//

import Foundation

extension Date {
    public var timeIntervalBeforeNow:TimeInterval {
        return -1.0 * self.timeIntervalSinceNow
    }
}
