//
//  worldclockController.swift
//  Clock 
//
//  Created by Akash Bhandari on 3/17/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

struct Clocks
    {
    
    let clock: NSTimeZone
 
    }

class worldclockController: UITableViewController
{
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem() //for edit button
        self.tableView.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "Handler:", name: "Bump", object: nil)
                
    }
    
    var worldClock = [Clocks] ()
    
    func Handler (notification : NSNotification)
    {
        var cityString = notification.object!.description
        worldClock += [Clocks(clock: NSTimeZone(name:cityString)!)]
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return worldClock.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("worldclockCell", forIndexPath: indexPath) as! ClockCell
        
        var timezone = worldClock[indexPath.row].clock
        
        cell.cityName.text = timezone.name
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone(name: timezone.name)
        
        cell.time.text = dateFormatter.stringFromDate(NSDate())
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            worldClock.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let clockToMove = worldClock[sourceIndexPath.row]
        worldClock.removeAtIndex(sourceIndexPath.row)
        worldClock.insert(clockToMove, atIndex: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
}

