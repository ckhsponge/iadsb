//
//  CoreLocation.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation
import CoreLocation

public struct CoreLocation {
    public class Device: iADSB.DeviceNetwork {
        class Delegate: NSObject, CLLocationManagerDelegate {
            var device:CoreLocation.Device
            init(_ device:CoreLocation.Device ) {
                self.device = device
            }
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if let location = locations.last {
                    device.previousGPS = device.gps
                    device.gps = CoreLocation.GPS(location: location, previousGPS: device.previousGPS, device:device)
                    device.manager.update( device:device )
                }
            }
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                print("CLLocationManager ERROR: \(error)")
            }
        }
        
        override public var name:String { return "Internal" }
        
        lazy var delegate = Delegate( self )
        var locationManager:CLLocationManager = CLLocationManager()
        public static var requestAlwaysAuthorization = false
        var previousGPS:iADSB.GPS? = nil
        override public func start() {
            super.start()
            let status = CLLocationManager.authorizationStatus()
            if status == CLAuthorizationStatus.notDetermined {
                if CoreLocation.Device.requestAlwaysAuthorization {
                    locationManager.requestAlwaysAuthorization()
                } else {
                    locationManager.requestWhenInUseAuthorization()
                }
            }
            else if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied {
                return
            }
            locationManager.delegate = delegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
        
        override public func stop() {
            super.stop()
            locationManager.stopUpdatingLocation()
        }
        
        override public func checkOnce() {
            // TODO
        }
    }
}

