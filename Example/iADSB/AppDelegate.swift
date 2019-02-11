//
//  AppDelegate.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/2018.
//  Copyright (c) 2018 Christopher Hobbs. All rights reserved.
//

import UIKit
import iADSB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let manager = IADSB.Manager()
    let defaults = AppDefaults()

    static var instance:AppDelegate { return (UIApplication.shared.delegate! as! AppDelegate) }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initDevices()
//        testAttributes()
//        testJson()
        return true
    }
    
    func initDevices() {
        var devices = [IADSB.Device]()
        for identifier in defaults.enabledDevices {
            switch identifier {
            case .stratux:
//                devices(IADSB.Stratux.Device(manager, priority: 10))
                devices.append(IADSB.Stratux.DeviceLocal(manager, priority: 10))
            case .stratuxHttp:
                devices.append(IADSB.Stratux.DeviceHttp(manager, priority: 9))
            case .coreLocation:
                devices.append(IADSB.CoreLocation.Device(manager, priority: 8))
            }
        }
        manager.devices = devices
    }
    
    func testAttributes() {
        let attributes:[String:Any] = ["GPSLatitude": 37.7749,"GPSLongitude":-122.4194,"GPSVerticalAccuracy": 0,"GPSHorizontalAccuracy": 0]
        let device = IADSB.DeviceNetwork(manager)
        let gps = device.serviceFrom(IADSB.Stratux.GPS.self, attributes: attributes)
        print("GPS attributes \(String(describing: gps?.description))")
    }
    
    func testJson() {
        let s = "      { \"GPSLastFixSinceMidnightUTC\": 78047.7,\n\"GPSLatitude\": 37.7749,\n\"GPSLongitude\":-122.4194,\n\"GPSVerticalAccuracy\": 0,\n\"GPSHorizontalAccuracy\": 0\n}"
        let device = IADSB.DeviceNetwork(manager)
        let gps = device.serviceFrom(IADSB.Stratux.GPS.self, jsonString: s)
        print("GPS json \(String(describing: gps?.description))")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

