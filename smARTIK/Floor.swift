//
//  Floor.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-19.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import Foundation

class Floor {
    private var _rooms: Set<Room>!
    
    var rooms: Set<Room> {
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
        self._rooms.insert(room)
    }
    
    func removeRoom(room: Room) {
        self._rooms.remove(room)
    }
    
    func count() -> Int {
        return _rooms.count
    }
    
    init(rooms: Set<Room>) {
        _rooms = Set<Room>(rooms)
    }
    
}
