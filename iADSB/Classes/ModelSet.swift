//
//  ModelSet.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/26/18.
//

import Foundation

extension IADSB {
    public struct ModelSet<T>:Sequence where T:IADSB.Model {
        public var models = [String:T]()
        
        public mutating func insert(_ model:T) {
            models[model.providerName] = model
        }
        
        public var array:[T] {
            return models.values.sorted()
        }
        
        public func makeIterator() -> IndexingIterator<[T]> {
            return array.makeIterator()
        }
        
        public var first:T? {
            return array.first
        }
        
        public var providers:Set<Provider> {
            return Set<Provider>(models.values.compactMap({ (model) -> Provider? in
                model.provider
            }))
        }
    }
}
