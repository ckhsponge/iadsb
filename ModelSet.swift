//
//  ModelSet.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/26/18.
//

import Foundation

extension IADSB {
    public struct ModelSet<T> where T:IADSB.Model {
        public var set:[String:T] = [String:T]()
        
        public mutating func add(_ model:T) {
            set[model.providerName] = model
        }
        
        public var models:[T] {
            return Array(set.values).sorted()
        }
    }
}
