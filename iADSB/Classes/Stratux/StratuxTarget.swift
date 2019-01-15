//
//  StratuxTarget.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/2/19.
//

import Foundation

public extension IADSB {
    public struct Stratux {}
}
public extension IADSB.Stratux {
    public class Target: IADSB.Traffic.Target {
        override public class var keyMapping:[String:String]? {
            return  [   "Lat":"latitude",
                        "Lng":"longitude",
                        "Alt":"altitude",
                        "Speed":"speed",
                        "Vvel":"verticalSpeed",
                        "Bearing":"bearingTrue",
                        "Track":"trackTrue",
                        "Position_valid":"positionValid",
                        "BearingDist_valid":"bearingValid",
                        "Speed_valid":"speedValid",
                        "OnGround":"onGround",
                        "Icao_addr":"icaoAddress",
                        "Reg":"registraion",
                        "Tail":"tailNumber",
                        "Squawk":"squawk",
                        "Last_alt":"altitudeAt",
                        "Last_seen":"positionAt",
                        "Last_speed":"speedAt",
                        "Timestamp":"timestamp"
            ]
        }
    }
}

//
//Addr_type: 0
//Age: 1.84
//AgeLastAlt: 0.63
//Alt: 12900
//AltIsGNSS: false
//Bearing: 0
//BearingDist_valid: false
//Distance: 0
//Emitter_category: 3
//ExtrapolatedPosition: false
//GnssDiffFromBaroAlt: 325
//Icao_addr: 11084956
//Last_GnssDiff: "0001-01-01T00:09:32.9Z"
//Last_GnssDiffAlt: 12800
//Last_alt: "0001-01-01T00:09:34.92Z"
//Last_seen: "0001-01-01T00:09:34.92Z"
//Last_source: 1
//Last_speed: "0001-01-01T00:09:32.9Z"
//Lat: 37.506252
//Lng: -122.42137
//NACp: 9
//NIC: 8
//OnGround: false
//Position_valid: true
//PriorityStatus: 0
//Reg: "N68891"
//SignalLevel: -21.630432629404496
//Speed: 373
//Speed_valid: true
//Squawk: 6345
//Tail: "UAL358"
//TargetType: 1
//Timestamp: "2019-01-02T19:21:29.787Z"
//Track: 139
//Vvel: 2688
