//
//  RoomDetailVC.swift
//  OldRooms
//
//  Created by Cathal Farrell on 18/08/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import UIKit

class RoomDetailVC: UIViewController {
    
    var room: Room!

    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var videoImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = room.name
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.roomImage.image = UIImage(named: room.imageName)

        self.videoImage.alpha = room.hasVideo ? 1.0 : 0.0

        setUpGestureRecogniser()
    }

    func setUpGestureRecogniser() {
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        tapGestureRecogniser.numberOfTapsRequired = 1
        roomImage.isUserInteractionEnabled = true
        roomImage.addGestureRecognizer(tapGestureRecogniser)
    }

    @objc func didTap(sender: UITapGestureRecognizer) {

        //Transition of image content mode

        let contentMode: UIView.ContentMode = roomImage.contentMode
            == .scaleAspectFit ? .scaleAspectFill : .scaleAspectFit


        // Transition options:
        // .transitionFlipFromBottom, .curveEaseInOut, .transitionCrossDissolve, etc...

        UIView.transition(with: roomImage,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.roomImage.contentMode = contentMode
                          },
                          completion: nil)

        if room.hasVideo {
            //Transition video image
            let alphaMode: CGFloat = videoImage.alpha == 0.0 ? 1.0 : 0.0

            UIView.transition(with: videoImage,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.videoImage.alpha = alphaMode
                              },
                              completion: nil)
        }
    }
}
