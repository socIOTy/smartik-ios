//
//  Room.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-19.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import Foundation

class Room : Hashable {
    
    private var _name: String!
    private var _devices: Set<String>!
    
    var name: String {
        get {
            if _name == nil {
                return ""
            } else {
                return _name
            }
        }
        set {
            _name = newValue
        }
    }
    
    var devices: Set<String> {
        get {
            if _devices.count == 0 || _devices == nil {
                return []
            } else {
            return _devices
            }
        }
        set {
            _devices = newValue
        }
    }
    var hashValue: Int {
        return _name.hashValue ^ _name.hashValue
    }
    
    init() {
        
    }
    
    init(name: String, devices: Set<String>) {
        self._name = name
        self._devices = devices
    }
    
    func addDevice(id: String) {
        _devices.insert(id)
    }
    
    func removeDevice(id: String) {
        _devices.remove(id)
    }
    
    static func ==(lhs: Room, rhs: Room) -> Bool {
        if lhs._devices.elementsEqual(rhs._devices) {
            return true
        } else {
            return false
        }
    }
    
}
