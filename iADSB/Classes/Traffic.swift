//
//  Traffic.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/2/19.
//

import Foundation

public extension IADSB {
    public class Traffic: IADSB.Service {
        
        public var timestamp:Date?
        var targetsMap = [Int:Target]()
        
        public func add(_ target:IADSB.Target) {
            guard let icao = target.icaoAddress else { return }
            
            targetsMap[icao] = target
            timestamp = Date()
        }
        
        public var targetsText:String {
            let targets = targetsMap.values
            let strings = targets.map { (target) -> String in
                var array:[String?] = [target.tailNumber]
                if let squawk = target.squawk {
                    array.append(String(squawk))
                }
                if let altitude = target.altitude {
                    array.append(String(altitude))
                }
                return array.compactMap({$0}).joined(separator: "-")
            }
            return strings.joined(separator:" ")
        }
        
        public var count:Int {
            return targetsMap.count
        }
    }
}
