//
//  RoomStore.swift
//  OldRooms
//
//  Created by Cathal Farrell on 18/08/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import Foundation

class RoomStore {
    var rooms: [Room]
    
    init(rooms: [Room] = []) {
        self.rooms = rooms
    }
}
