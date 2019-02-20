//
//  Traffic.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/2/19.
//

import Foundation
import CoreLocation

public extension IADSB {
    public class Traffic: IADSB.Service {
        
        public var timestamp:Date?
        var targetsMap = [Int:Target]()
        let largeDistance = 1000000000000000000.0
        
        public var targets:[Target] {
            guard let location = managerLocation else {
                return targetsMap.values.sorted { (t1, t2) -> Bool in
                    if t1.speed != t2.speed {
                        return (t1.speed ?? 0.0) > (t2.speed ?? 0.0)
                    } else {
                        return (t1.altitude ?? 0.0) < (t2.altitude ?? 0.0)
                    }
                }
            }
            return targetsMap.values.sorted { (t1, t2) -> Bool in
                return (t1.distance(fromLocation:location) ?? largeDistance) < (t2.distance(fromLocation:location) ?? largeDistance)
            }
        }
        
        public var managerGPS:IADSB.GPS? {
            return self.device?.manager.gps
        }
        
        public var managerLocation:CLLocation? {
            return self.device?.manager.gps?.location
        }
        
        public func add(_ target:IADSB.Target) {
            guard let icao = target.icaoAddress, target.latitude != nil && target.longitude != nil else { return }
            
            targetsMap[icao] = target
            timestamp = Date()
        }
        
        public var count:Int {
            return targetsMap.count
        }
    }
}
