//
//  RoomCell.swift
//  OldRooms
//
//  Created by Cathal Farrell on 18/08/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {
    
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomCapacity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(room: Room) {
        self.roomImage.image = UIImage(named: room.thumbnailName)
        self.roomImage.layer.cornerRadius = 8
        self.roomName.text = room.name
        self.roomCapacity.text = "\(room.capacity)"
    }
}
