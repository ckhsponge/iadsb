//
//  ViewController.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/2018.
//  Copyright (c) 2018 Christopher Hobbs. All rights reserved.
//

import UIKit
import iADSB

class SettingsController: UIViewController {
    @IBOutlet var alwaysOnSwitch: UISwitch!
    @IBOutlet var devicesStack: UIStackView!
    @IBOutlet var servicesStack: UIStackView!
    
    var manager:Manager { return AppDelegate.instance.manager }
    var defaults:AppDefaults { return AppDelegate.instance.defaults }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alwaysOnSwitch.isOn = defaults.allDevicesAlwaysOn
        initSwitches(view: devicesStack, enums: defaults.enabledDevices)
        initSwitches(view: servicesStack, enums: defaults.enabledServices)
    }
    
    func initSwitches<E: RawRepresentable>(view:UIView, enums:[E]) where E.RawValue == String {
        if let uiswitch = view as? UISwitch {
            if let identifier = uiswitch.accessibilityIdentifier {
                let s = Set(enums.map { $0.rawValue })
                uiswitch.isOn = s.contains(identifier)
            } else {
                uiswitch.isOn = false
            }
        } else {
            for subview in view.subviews {
                initSwitches(view: subview, enums: enums)
            }
        }
    }
    
    @IBAction func alwaysOnAction(_ sender: Any) {
        AppDelegate.instance.defaults.allDevicesAlwaysOn = alwaysOnSwitch.isOn
    }
    
    @IBAction func devicesAction(_ sender: UISwitch) {
        print("enableDevicesAction \(sender.accessibilityIdentifier ?? "")")
        defaults.enableDevice(name: sender.accessibilityIdentifier, enabled: sender.isOn)
        AppDelegate.instance.initDevices()
    }
    
    @IBAction func servicesAction(_ sender: UISwitch) {
        print("servicesAction \(sender.accessibilityIdentifier ?? "")")
        defaults.enableService(name: sender.accessibilityIdentifier, enabled: sender.isOn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

