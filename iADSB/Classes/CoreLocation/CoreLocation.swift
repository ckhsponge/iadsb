//
//  CoreLocation.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation
import CoreLocation

public extension IADSB.CoreLocation {
    public class Provider: IADSB.Provider {
        class Delegate: NSObject, CLLocationManagerDelegate {
            var provider:Provider
            init(_ provider:Provider ) {
                self.provider = provider
            }
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if let location = locations.last {
                    provider.previousGPS = provider.gps
                    provider.gps = IADSB.CoreLocation.GPS(location: location, previousGPS: provider.previousGPS, provider:provider)
                    provider.manager.update( provider:provider )
                }
            }
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                print("CLLocationManager error: \(error)")
            }
        }
        
        override public var name:String { return "Internal" }
        
        lazy var delegate = Delegate( self )
        var locationManager:CLLocationManager = CLLocationManager()
        public static var requestAlwaysAuthorization = false
        var previousGPS:IADSB.GPS? = nil
        override public func start() {
            let status = CLLocationManager.authorizationStatus()
            if status == CLAuthorizationStatus.notDetermined {
                if IADSB.CoreLocation.Provider.requestAlwaysAuthorization {
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
    }
}
