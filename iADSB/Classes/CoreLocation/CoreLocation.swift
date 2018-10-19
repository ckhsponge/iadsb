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
                    provider.gps = IADSB.GPS(location: location, previousGPS: provider.previousGPS)
                    provider.manager.update( provider:provider )
                }
            }
        }
        
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
            locationManager.startUpdatingLocation()
        }
    }
}
