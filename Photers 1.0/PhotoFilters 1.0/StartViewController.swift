//
//  StartViewController.swift
//  Photers
//
//  Created by Akash Bhandari on 4/13/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var imgDisplay: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgDisplay.animationImages = [
            UIImage(named: "Eiffel Tower1.png")!,
            UIImage(named: "Eiffel Tower2.png")!,
            UIImage(named: "Eiffel Tower3.png")!,
            UIImage(named: "Eiffel Tower4.png")!,
            UIImage(named: "Eiffel Tower5.png")!
        ]
        imgDisplay.animationDuration = 8
        imgDisplay.startAnimating()
    }
    
    
}


