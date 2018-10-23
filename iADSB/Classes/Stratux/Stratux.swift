//
//  Stratux.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB.Stratux {
    public class Provider: IADSB.Provider {
        let urls:[String:[(IADSB.Model & Codable).Type]] = ["http://192.168.10.1/getSituation":[IADSB.Stratux.GPS.self]]
//        let urls:[String:[(IADSB.Model & Codable).Type]] = ["http://localhost:3000/stratux.json":[IADSB.Stratux.GPS.self]]
        
        var timer:Timer?
        
        func startTimer() {
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2.00001, target: self, selector: #selector(self.ping), userInfo: nil, repeats: true)
                self.timer?.tolerance = 0.1
            }
        }
    
        override public func start() {
            ping()
            startTimer()
        }
        
        @objc public func ping() {
            for (url,types) in urls {
                dataFrom(url: url) { (data) in
                    if let gps = self.modelFrom(IADSB.Stratux.GPS.self, data: data) {
                        self.gps = gps
                    }
                    if let barometer = self.modelFrom(IADSB.Stratux.Barometer.self, data: data) {
                        self.barometer = barometer
                    }
                    if let ahrs = self.modelFrom(IADSB.Stratux.AHRS.self, data: data) {
                        self.ahrs = ahrs
                    }
                    self.manager.update(provider: self)
                }
            }
        }
    }
}
