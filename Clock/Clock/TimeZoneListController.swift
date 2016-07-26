//
//  timeZoneListController.swift
//  Clock 
//
//  Created by Akash Bhandari on 3/20/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

class TimeZoneListController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate
{
    @IBOutlet var worldClockView: UITableView!
    
    @IBAction func cancelButton(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var timezoneArray = [WorldTimeZones] ()
    var filteredTimeZones = [WorldTimeZones] ()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for items in NSTimeZone.knownTimeZoneNames()
        {
            timezoneArray += [WorldTimeZones (timeZoneName: items)]
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            return self.filteredTimeZones.count
        }
        else
        {
            return self.timezoneArray.count
        }
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("timeZoneCell")! as UITableViewCell
        var timeZone : WorldTimeZones
        
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            timeZone = self.filteredTimeZones[indexPath.row]
        }
        else
        {
            timeZone = self.timezoneArray[indexPath.row]
        }
        
        cell.textLabel?.text = timeZone.timeZoneName
        return cell
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var timeZone : WorldTimeZones
        
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            timeZone = self.filteredTimeZones[indexPath.row]
        }
        else
        {
            timeZone = self.timezoneArray[indexPath.row]
        }
        // print(timeZone.timeZoneName)
        
        NSNotificationCenter.defaultCenter().postNotificationName("Bump", object: timeZone.timeZoneName)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    //Searching things
    
    func filterContentForSearchText(searchText: String, scope: String = "All")
    {
        self.filteredTimeZones = self.timezoneArray.filter({( timeZone: WorldTimeZones) -> Bool in
            
            var categoryMatch = (scope == "All")
            var stringMatch = timeZone.timeZoneName.rangeOfString(searchText)
            
            return categoryMatch && (stringMatch != nil)
            
        })
    
    }
    
   func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!, scope: "All")
        
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        self.filterContentForSearchText(searchString!, scope: "All")
        return true
    }
    
}


//NSTimeZone.knownTimeZoneNames()

