//
//  DeviceNetwork.swift
//  iADSB
//
//  Created by Christopher Hobbs on 11/6/18.
//

import Foundation
import Alamofire

public class DeviceHttp: DeviceNetwork {
    
    var timer:Timer?
    
    func startTimer() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { (timer) in
                self.checkOnce()
            })
            self.timer?.tolerance = 0.1
        }
    }
    
    override public func start() {
        super.start()
        startTimer()
    }
    
    override public func stop() {
        super.stop()
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override public func checkOnce() {
        for connection in connections {
            dataFrom(url: connection.url) { (data) in
                for type in connection.types {
                    self.setServiceFrom(type.self, data: data)
                }
                self.manager.update(device: self)
            }
        }
    }
    
    public func dataFrom(url:String, completionHandler: @escaping (Data) -> Void) {
        Alamofire.request(url).responseData { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            //                print("Response: \(String(describing: response.response))") // http url response
            //                print("Result: \(response.result)")                         // response serialization result
            
            guard let data = response.data else {
                print("No data from \(url)")
                return
            }
            if data.isEmpty {
                print("Empty data from \(url)")
                return
            }
            completionHandler(data)
        }
    }
}
