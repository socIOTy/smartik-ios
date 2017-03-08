//
//  ThermostatVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-03.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class ThermostatVC: UIViewController {
    
    private var _device: Device!
    
    var device : Device {
        get {
            return _device
        }
        set {
            _device = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


    

}
