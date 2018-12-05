//
//  ProtocolSet.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/28/18.
//

import Foundation

extension IADSB {
    struct ProtocolSet<T>:Sequence {
        private var objects = [T]()
        
        public mutating func add(_ object:T ) {
            if contains( object ) {
                return
            }
            objects.append(object)
        }
        
        public func contains(_ object:T ) -> Bool {
            return indexOf(object) != nil
        }
        
        public func containsAny(_ collection:[T]) -> Bool {
            for o in collection {
                if contains(o) { return true }
            }
            return false
        }
        
        public mutating func remove(_ object:T ) {
            if let index = indexOf( object ) {
                objects.remove(at: index)
            }
        }
        
        public func indexOf(_ object:T ) -> Int? {
            for (index, o) in objects.enumerated() {
                if object as AnyObject === o as AnyObject {
                    return index
                }
            }
            return nil
        }
        
        public func toArray() -> Array<T> {
            return Array<T>(objects)
        }
        
        public func makeIterator() -> IndexingIterator<[T]> {
            return objects.makeIterator()
        }
    }
}
