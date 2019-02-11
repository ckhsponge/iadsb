//
//  ServiceSet.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/26/18.
//

import Foundation

extension IADSB {
    public struct ServiceSet<T>:Sequence where T:IADSB.Service {
        public var services = [String:T]()
        
        public mutating func insert(_ service:T) {
            services[service.deviceName] = service
        }
        
        public var array:[T] {
            let sorted = services.values.sorted()
            return sorted
        }
        
        public func makeIterator() -> IndexingIterator<[T]> {
            return array.makeIterator()
        }
        
        public var first:T? {
            return array.first
        }
        
        public var devices:Set<Device> {
            return Set<Device>(services.values.compactMap({ (service) -> Device? in
                service.device
            }))
        }
    }
}
