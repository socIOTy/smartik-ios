//
//  Floor.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-19.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import Foundation

class Floor {
    private var _rooms: [Room]!
    
    var rooms: [Room] {
        get {
            if _rooms.isEmpty {
                return []
            } else {
                return _rooms
            }
        }
        set {
            _rooms = newValue
        }
    }
    
    func addRoom(room: Room) {
        self._rooms.append(room)
    }
    
    func count() -> Int {
        return _rooms.count
    }
    
    init(rooms: [Room]) {
        _rooms = rooms
    }
    
    
}
