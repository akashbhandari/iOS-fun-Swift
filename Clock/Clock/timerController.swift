//
//  timerController.swift
//  Clock 
//
//  Created by Akash Bhandari on 3/21/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

class timerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var timerView: UIPickerView!
   
    var pickerDataSource = ["0", "1", "2", "3", "4", "5", "6", "7", "9"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.timerView.dataSource = self;
        self.timerView.dataSource = self;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource [row]
    }
    
}

