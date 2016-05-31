//
//  ViewController.swift
//  Reminder
//
//  Created by Warp on 17/12/2014.
//  Copyright (c) 2014 Warp. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let myArray = ["Notification", "Option 2", "Option 3","Option 4,"Option 5"]
        //Outlet
    @IBOutlet weak var tableReminder: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell

     
          let cellContent = self.myArray[indexPath.row]
           cell.textLabel!.text = cellContent
        
        return cell
    }
    
 
    
    func dateNow(days:Double) -> NSDate
    {
        let now = NSDate()
        let date = now.dateByAddingTimeInterval((24 * days) * 3600)
        return date
    }
    
    func dateToString(dates:NSDate) -> String
    {
        var dateString:String
        var date = NSDate()
        date = dates
        let formatter = NSDateFormatter()
        formatter.timeStyle = .LongStyle
        dateString = formatter.stringFromDate(date)
        return dateString

    }
}

