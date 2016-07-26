//
//  ViewController.swift
//  Calculator
//
//  Created by Akash Bhandari on 3/5/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var zeroDoesNotExist: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (zeroDoesNotExist == true) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            zeroDoesNotExist = true
        }
        
        
        if (digit == "C") {
            display.text = "0"
            zeroDoesNotExist = false
        }
        
        if (digit == "+") {
            display.text = display.text!
            
        } //mistake
        
        //print("digit = \(digit)")
    }
}


/*

Assignment operator -> = 
var a : bool = true;

Comparison operator -> ==
if a == true {

}
*/