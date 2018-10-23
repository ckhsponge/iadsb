//
//  ViewController.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/2018.
//  Copyright (c) 2018 Christopher Hobbs. All rights reserved.
//

import UIKit
import iADSB

class ViewController: UIViewController,IADSBDelegate {

    @IBOutlet var internalTextView: UITextView!
    @IBOutlet var stratuxGPSTextView: UITextView!
    @IBOutlet var stratuxBaroTextView: UITextView!
    @IBOutlet var stratuxAHRSTextView: UITextView!
    
    
    var manager = IADSB.Manager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        IADSB.Network().go()
//        IADSB.Network().data()
//        let gps = IADSB.Stratux.GPS().create( attributes: ["GPSLatitude":1.0, "GPSLongitude":2.0] )
//        let klass = IADSB.Stratux.GPS.self
//        print("klass \(klass) \(type(of:klass))")
//        let gps1 = IADSB.Model.from( IADSB.Stratux.GPS.self, attributes: ["latitude":1.0, "longitude":2.0] )
//        print("launch \(String(describing: gps1.latitude))")
//        print("launch \(String(describing: gps1.longitude))")
//        let gps = IADSB.Model.from( IADSB.Stratux.GPS.self, attributes: ["GPSLatitude":1.0, "GPSLongitude":2.0] )
////        print("launch \(String(describing: gps.attributes))")
//        print("launch \(String(describing: gps.latitude))")
//        print("launch \(String(describing: gps.longitude))")
//        print("launch \(String(describing: gps.location))")
//        textView.text = "\(gps.attributes) \(String(describing: gps.location))"
        //manager.providers = [IADSB.Stratux.Provider(manager)]
        manager.add(delegate: self)
        manager.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func update(provider: IADSB.Provider) {
//        print("GPS Update: \(gps)")
        if let internalProvider = provider as? IADSB.CoreLocation.Provider {
            internalTextView.text = String(describing: internalProvider.gps?.description)
        } else if let stratuxProvider = provider as? IADSB.Stratux.Provider {
            stratuxGPSTextView.text = String(describing: stratuxProvider.gps?.description)
            stratuxBaroTextView.text = String(describing: stratuxProvider.barometer?.description)
            stratuxAHRSTextView.text = String(describing: stratuxProvider.ahrs?.description)
        }
    }
}

