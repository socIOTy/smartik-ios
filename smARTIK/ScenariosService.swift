//
//  ScenariosService.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-18.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import Foundation
import ArtikCloudSwift3

class ScenariosService {
    static func setLightsOff() {
        self.setBulbState(state: false)
    }
    
    static func setLightsOn() {
        self.setBulbState(state: true)
    }
    
    static func setHome() {
        self.setBulbState(state: true)
        self.setThermostatState(stateIndex: 1)
    }
    
    static func setAway() {
        self.setBulbState(state: false)
        self.setThermostatState(stateIndex: 0)
    }
    
    static func setSaving() {
        setIntensity(intensity: 30)
        setTemperature(temp: 20)
    }
    
    static func sendGroupAction(actionArray: ActionArray, dtid: String) {
        UsersAPI.getUserDevices(userId: UserDefaults.standard.getUserId()).then { result -> Void in
            let devices = result.data?.devices
            for device in devices! {
                if device.dtid == dtid {
                    self.sendAction(actionArray: actionArray, id: device.id!)
                }
            }
            }.catch { error -> Void in
                
                print(String(format: "%s", String(describing: error)))
        }
    }
    
    static func sendAction(actionArray: ActionArray, id: String) {
        var actions = Actions()
        actions.ddid = id
        actions.data = actionArray
        
        MessagesAPI.sendActions(data: actions).then {
            response -> Void in
            }.catch{error -> Void in
                print(String(format: "%s", String(describing: error)))
        }
    }
    
    static func setBulbState(state: Bool) {
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        action.name = state ? "setOn" : "setOff"
        actionArray.actions = []
        actionArray.actions!.append(action)
        sendGroupAction(actionArray: actionArray, dtid: Metadata.devicesTypesWithNames["Light Bulb"]!)
    }
    
    static func setThermostatState(stateIndex: Int) {
        var state = ""
        switch stateIndex {
        case 0: state = "setOff"
            break
        case 1: state = "setHeatCoolMode"
            break
        case 2: state = "setHeatMode"
            break
        case 3: state = "setCoolMode"
            break
        default: break
        }
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        action.name = state
        actionArray.actions = []
        actionArray.actions!.append(action)
        sendGroupAction(actionArray: actionArray, dtid: Metadata.devicesTypesWithNames["Thermostat"]!)
    }
    
    static func setTemperature(temp: Int) {
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        action.name = "setTemperature"
        action.parameters = ["temp" : temp]
        actionArray.actions = []
        actionArray.actions!.append(action)
        sendGroupAction(actionArray: actionArray, dtid: Metadata.devicesTypesWithNames["Thermostat"]!)
    }
    
    static func setIntensity(intensity: Int) {
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        
        action.name = "setIntensity"
        
        action.parameters = ["intensity" : intensity]
        
        actionArray.actions = []
        actionArray.actions!.append(action)
        sendGroupAction(actionArray: actionArray, dtid: Metadata.devicesTypesWithNames["Light Bulb"]!)
    }
}
