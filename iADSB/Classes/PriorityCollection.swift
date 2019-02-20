//
//  PriorityCollection.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/27/18.
//

import Foundation

struct PriorityCollection:Sequence {
    var array:[Device]
    
    init() {
        self.array = [Device]()
    }
    
    init(_ array:[Device]) {
        self.array = array
    }
    
    func objectsGreaterThan(priority:Int) -> [Device] {
        return array.filter({ (device) -> Bool in
            device.priority > priority
        })
    }
    
    
    func objectsWith(priority:Int) -> [Device] {
        return array.filter({ (device) -> Bool in
            device.priority == priority
        })
    }
    
    
    func objectsLessThan(priority:Int) -> [Device] {
        return array.filter({ (device) -> Bool in
            device.priority < priority
        })
    }
    
    public func makeIterator() -> IndexingIterator<[Device]> {
        return array.makeIterator()
    }
}

