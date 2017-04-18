//
//  Scenario.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-18.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import Foundation

class Scenario {
    private var _name: String!
    private var _action: ScenarioAction!
    
    var name: String {
        get {
            if _name != nil {
                return _name
            } else {
                return ""
            }
        }
    }
    
    var action: ScenarioAction {
        get {
            if _action != nil {
                return _action
            } else {
                return .none
            }
        }
    }
    
    init(name: String, action: ScenarioAction) {
        self._name = name
        self._action = action
    }
    
}
