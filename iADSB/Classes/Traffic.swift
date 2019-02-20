//
//  Traffic.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/2/19.
//

import Foundation
import CoreLocation

public class Traffic: iADSB.Service {
    public var timestamp:Date?
    var targetsMap = [Int:Target]()
    let largeDistance = 1000000000000000000.0
    
    private let dispatchQueue = DispatchQueue( label: "net.toonsy.iADSB.traffic", attributes: .concurrent)
    
    // returns targets sorted by distance if location is available
    // otherwise sorts by speed, altitude
    public var targets:[Target] {
        var values:[Target]!
        dispatchQueue.sync {
            values = Array<Target>(self.targetsMap.values)
            if let location = managerLocation {
                values = values.sorted { (t1, t2) -> Bool in
                    return (t1.distance(fromLocation:location) ?? largeDistance) < (t2.distance(fromLocation:location) ?? largeDistance)
                }
            } else {
                values = values.sorted { (t1, t2) -> Bool in
                    if t1.speed != t2.speed {
                        return (t1.speed ?? 0.0) > (t2.speed ?? 0.0)
                    } else {
                        return (t1.altitude ?? 0.0) < (t2.altitude ?? 0.0)
                    }
                }
            }
        }
        return values
    }
    
    public var managerGPS:GPS? {
        return self.device?.manager.gps
    }
    
    public var managerLocation:CLLocation? {
        return self.device?.manager.gps?.location
    }
    
    public func add(_ target:Target) {
        guard let icao = target.icaoAddress else { return }
        
        dispatchQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            if target.latitude != nil && target.longitude != nil {
                self.targetsMap[icao] = target
                self.timestamp = Date()
            } else {
                self.targetsMap.removeValue(forKey: icao)
            }
        }
    }
    
    public var count:Int {
        return targetsMap.count
    }
}

