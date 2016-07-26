//
//  StopWatchController.swift
//  Clock 
//
//  Created by Akash Bhandari on 3/17/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

class StopWatchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var laps: [String] = []
    
    var timer = NSTimer ()
    var seconds: Int = 0
    var minutes: Int = 0
    var fractions: Int = 0
    
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    var stopwatchString: String = ""
    
    @IBOutlet weak var smallStopWatch: UILabel!
    
    @IBOutlet weak var bigStopWatch: UILabel!

    @IBOutlet weak var lapresetButton: UIButton!

    @IBOutlet weak var startstopButton: UIButton!
    
    @IBOutlet weak var lapTableView: UITableView!
    
    //For the lapreset button
    
    @IBAction func lapreset(sender: AnyObject) {
        
        if addLap == true {
            laps.insert(stopwatchString, atIndex: 0)
            lapTableView.reloadData()
            
            
            
            
        }else {
            addLap = false
            
            lapresetButton.setImage(UIImage(named: "lapButton.png"), forState: .Normal)
            laps.removeAll(keepCapacity: false)
            lapTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopwatchString = "00:00:00"
            bigStopWatch.text = stopwatchString
        
            
        }
        
    }
    
    //For the startstop method
    
    @IBAction func startstop(sender: AnyObject) {
        
        if startStopWatch == true {
    
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector ("updateStopWatch"), userInfo: nil, repeats: true)
            startStopWatch = false
            
            startstopButton.setImage(UIImage (named: "stopButton.png"), forState: UIControlState.Normal)
            lapresetButton.setImage(UIImage (named: "lapButton.png"), forState: UIControlState.Normal)
            
            addLap = true
       
        } else {
            timer.invalidate()
            startStopWatch = true
            
            startstopButton.setImage(UIImage(named: "startButton.png"), forState: .Normal)
            lapresetButton.setImage(UIImage(named: "resetButton.png"), forState: .Normal)
            
            addLap = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigStopWatch.text = "00:00:00"
    }
    
    func updateStopWatch() {
        
        fractions += 1
        
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        bigStopWatch.text = stopwatchString
        
        
    }

    
    
    //Table View Methods below the stopwatch 
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel!.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps [indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
}


