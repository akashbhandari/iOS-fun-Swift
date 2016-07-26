//
//  ViewController.swift
//  ToDo List
//
//  Created by Akash Bhandari on 3/27/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit
import CoreData

class tableViewController: UITableViewController {
    
    var listItems = [ NSManagedObject] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Adding new item in table view
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector ("addItem"))
    }
    
    //to add window
    
    func addItem() {
        let alertController = UIAlertController(title: "Confirm", message: "Type......", preferredStyle: UIAlertControllerStyle.Alert) //can also use .Alert in preferredStyle:
        
        let confirmAction = UIAlertAction (title: "Confirm", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            
            if let field = alertController.textFields![0] as? UITextField{
                
                self.saveItem(field.text!)
                self.tableView.reloadData()
            }
            
            
            }
        ))
        
        let cancelAction = UIAlertAction (title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        //adding textfield inside UIalertcontroller
        
        alertController.addTextFieldWithConfigurationHandler({
            (UITextField) in
            
            UITextField.placeholder = "Type Anything!!"
            
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //to save items
    
    func saveItem (savingItem: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("ListEntity", inManagedObjectContext: managedContext)
        
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        item.setValue(savingItem, forKey: "item") //item from coredata
        
        do {
            try managedContext.save()
            
            listItems.append(item)
            
        }
        catch {
            print ("There was an error!")
        }
        
    }
    //Loading up even after closing 
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest (entityName: "ListEntity")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            listItems = results as! [NSManagedObject]
            
        }
        catch {
            print ("error 101")
        }
    }
    
    //Removing notes from saved ones
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle) // deletion animation
        
        let managedContext = appDelegate.managedObjectContext
        
        managedContext.deleteObject(listItems[indexPath.row])
        
        listItems.removeAtIndex(indexPath.row)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count 
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        let item =  listItems [indexPath.item]
        
        cell.textLabel?.text = item.valueForKey("item") as! String
        
        return cell
    }


}