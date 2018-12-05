//
//  PriorityCollection.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/27/18.
//

import Foundation

public extension IADSB {
    struct PriorityCollection:Sequence {
        var array:[Provider]
        
        init() {
            self.array = [Provider]()
        }
        
        init(_ array:[Provider]) {
            self.array = array
        }
        
        func objectsGreaterThan(priority:Int) -> [Provider] {
            return array.filter({ (provider) -> Bool in
                provider.priority > priority
            })
        }
        
        
        func objectsWith(priority:Int) -> [Provider] {
            return array.filter({ (provider) -> Bool in
                provider.priority == priority
            })
        }
        
        
        func objectsLessThan(priority:Int) -> [Provider] {
            return array.filter({ (provider) -> Bool in
                provider.priority < priority
            })
        }
        
        public func makeIterator() -> IndexingIterator<[Provider]> {
            return array.makeIterator()
        }
    }
}
