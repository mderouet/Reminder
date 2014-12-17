//
//  ViewController.swift
//  Reminder
//
//  Created by Warp on 17/12/2014.
//  Copyright (c) 2014 Warp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //Variable
    var myTab = Array<String>()
    
    //Outlet
    @IBOutlet weak var tableReminder: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTab.append("Faire la cuisine")
        myTab.append("Faire la vaiselle")
        myTab.append("Jesus Christ")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTab.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("custom") as UITableViewCell
        
        cell.textLabel.text = String(myTab[indexPath.row])
        if let detailLabel = cell.detailTextLabel {
            detailLabel.text = "detail text"
        }
        return cell;
    }
    
    

}

