//
//  RoomDetail.swift
//  Rooms
//
//  Created by Cathal Farrell on 18/08/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct RoomDetail: View {

    let room: Room
    @State private var zoomed = false

    var body: some View {
        ZStack(alignment: .topLeading){
            Image(room.imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit)
                .navigationBarTitle(Text(room.name), displayMode: .inline)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 1.0)) {
                        self.zoomed.toggle()
                    }
                }

                //By using this, the overlayed video image below is placed on top left of screen
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)


            if room.hasVideo && !zoomed {
                Image(systemName: "video.fill")
                .font(.title)
                .padding(.all)
                    .transition(.move(edge: .leading))
            }
        }
    }
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView { RoomDetail(room: testData[0]) }
            NavigationView { RoomDetail(room: testData[1]) }
        }
    }
}
