//
//  RoomStore.swift
//  Rooms
//
//  Created by Cathal Farrell on 18/08/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI
import Combine

class RoomStore: ObservableObject {
    @Published var rooms: [Room]

    init(rooms: [Room] = []) {
        self.rooms = rooms
    }
}
