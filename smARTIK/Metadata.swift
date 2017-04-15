//
//  Metadata.swift
//  LightBulb
//
//  Created by Serhii Pianykh on 2017-02-08.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import Foundation

class Metadata {
    //settings
    //static let deviceID = "d3925804714a42d5a07e9486740f666c"
    static let appClientID: String = "011e3fa3324e46169dc76b2989985884"
    
    //
    static let appRedirectURI: String = "smartik://callback"
    static let appState: String = "bla-bla-bla"
    
    static let deviceTypes: [String:String] = ["dt71c282d4fad94a69b22fa6d1e449fbbb":"LightBulbVC", "dt5247379d38fa4ac78e4723f8e92de681":"ThermostatVC"]
    
    static let devicesTypesWithNames: [String:String] = ["Light Bulb": "dt71c282d4fad94a69b22fa6d1e449fbbb", "Thermostat" : "dt5247379d38fa4ac78e4723f8e92de681"]
    
    static let devicesRestURL = "https://smartik.herokuapp.com/rest/device"
}
