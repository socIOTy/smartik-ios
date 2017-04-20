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
    
    
    func countRooms() -> Int {
        var result = 0
        for floor in floors {
            result += floor.count()
        }
        return result
    }
    
    init() {
        _floors = [Floor]()
    }
    
    init(data: Dictionary<String,Any>) {
        print(data)
        if let dataFloors = data["floors"] as? [Dictionary<String,Any>] {
            _floors = [Floor]()
            for floor in dataFloors {
                if let dataRooms = floor["rooms"] as? [Dictionary<String,Any>] {
                    var rooms = Set<Room>()
                    for room in dataRooms {
                        let roomName = room["name"] as? String
                        if let roomDevices = room["deviceIds"] as? [String] {
                            var devices = Set<String>()
                            for device in roomDevices {
                                devices.insert(device)
                            }
                            let room = Room(name: roomName!, devices: devices)
                            rooms.insert(room)
                        }
                        
                    }
                    _floors.append(Floor(rooms: Array(rooms).sorted(by: {$0.name < $1.name})))
                }
                
            }
            
        }
    }
}
