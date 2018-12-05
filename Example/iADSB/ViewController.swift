//
//  ViewController.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/2018.
//  Copyright (c) 2018 Christopher Hobbs. All rights reserved.
//

import UIKit
import iADSB

class ViewController: UIViewController {
    @IBOutlet var alwaysOnSwitch: UISwitch!
    
    var manager:IADSB.Manager { return AppDelegate.instance.manager }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alwaysOnSwitch.isOn = AppDelegate.instance.defaults.allProvidersAlwaysOn
    }
    
    @IBAction func alwaysOnAction(_ sender: Any) {
        AppDelegate.instance.defaults.allProvidersAlwaysOn = alwaysOnSwitch.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

