//
//  DeviceMap.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-19.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import Foundation
class DeviceMap {
    
    private var _floors: [Floor]!
    
    var floors: [Floor] {
        get{
            if _floors.count == 0 {
                return []
            } else {
                return _floors
            }
        }
        set {
            _floors = newValue
        }
    }
    
    init(floors: [Floor]) {
        self._floors = floors
    }
    
    func addRoom(floorNumber: Int, name: String) {
        if floorNumber >= _floors.count {
            for i in _floors.count...floorNumber {
                _floors.append(Floor(rooms: Set<Room>()))
            }
        }
        _floors[floorNumber].addRoom(room: Room(name: name, devices: []))
    }
    
    func getRoom(name: String ) -> Room {
        for floor in _floors {
            for room in floor.rooms {
                if room.name == name {
                    return room
                }
            }
        }
        return Room()
    }
    
    func removeRoom(roomDelete: Room){
        for floor in floors {
            for room in floor.rooms {
                if room == roomDelete {
                    floor.removeRoom(room: room)
                }
            }
        }
    }
    
    func countRooms() -> Int {
        result = 0
        for floor in floors {
            result += floor.count()
        }
        return result
    }
}
