//
//  ViewController.swift
//  test 2
//
//  Created by Akash Bhandari on 3/2/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var i = 0
    var j = 0

    @IBOutlet weak var image: UIImageView!
    
    @IBAction func myBtn(sender: UIButton) {
        image.image = UIImage(named:"maldives-8")
        
    }
    
    @IBOutlet weak var myLabel: UITextField!
    
    @IBAction func myButton(sender: AnyObject) {
        let defaultText = "I am Akash, a second term freshman at Bennington College. I always loved the smoothness and the easy user interface of iOS. By taking this class, I intend to make an app that would be sleek as well as user friendly. I started progamming about a year ago. At first, I was into making websites using HTML and CSS. Now, I want to broaden my knowledge in computer science. I am really excited for this class as I want to challenge myself to greater extent and learn new things."
        
        let changeText = "My friends also call me AK. You can call me Akash/AK."
        
        if (i == 0) {
            myLabel.text = changeText
            i = 1
        } else if (i == 1) {
            myLabel.text = defaultText
            i = 0
        }
        
    
    }
    
}

