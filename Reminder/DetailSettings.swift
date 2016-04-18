//
//  DetailSettings.swift
//  Reminder
//
//  Created by Warp on 17/12/2014.
//  Copyright (c) 2014 Warp. All rights reserved.
//

import UIKit

class DetailSettings: UIViewController {

    //Variable
    var strDateShort:String = "No Reminder Defined"
    var DateLong:NSDate? = nil
    
    //UserDefaults
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    //Date Picker
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var labelHour: UILabel!
    
    //Switch
    @IBOutlet weak var switchReminder: UISwitch!
    @IBOutlet weak var labelSwitch: UILabel!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Launch the Event datePicker listener
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        datePicker.datePickerMode = UIDatePickerMode.Time
    }

    override func viewWillAppear(animated: Bool) {
        // Refresh label time and switch state with nsUser
        setupSwitch()
        refreshLabel()
    }
    
    // Listener value Date Picker
    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        strDateShort = dateFormatter.stringFromDate(datePicker.date)
        
        let dateFormatter2 = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd h:mm a"
        DateLong = datePicker.date
    }
 

    func refreshLabel()
    {
        let valueSwitch:String? = userDefaults.valueForKey("switchReminderState") as? String
        let time:String? = userDefaults.valueForKey("timeReminder") as? String
        if(time != nil && valueSwitch == "true"){
        labelHour.text = "Current time :" + time!
        }
        else
        {
            labelHour.text = "No Reminder defined"
        }
    }
    
    
    //Listener Switch
    @IBAction func onclickSwitch(sender: AnyObject) {
       configureSwitch()
    }
    
    func setupSwitch()
    {
        let valueSwitch:String? = userDefaults.valueForKey("switchReminderState") as? String
        if(valueSwitch == "true")
        {
            switchReminder.setOn(true,animated:true)
            labelSwitch.text = "Reminder enabled"
        }
        else
        {
            switchReminder.setOn(false, animated: true)
            labelSwitch.text = "Reminder disabled"
        }

    }
    
    // Change switch state
    func configureSwitch()
    {
    let valueSwitch:String? = userDefaults.valueForKey("switchReminderState") as? String
        if(valueSwitch == "true")
        {
            switchReminder.setOn(false, animated: true)
            labelSwitch.text = "Reminder disabled"
            userDefaults.setValue("false", forKey: "switchReminderState")
            
            
            deletePreviousNotifications()
            userDefaults.setValue("Null", forKey: "timeReminder")
            refreshLabel()
        }
        else
        {
            switchReminder.setOn(true,animated:true)
            labelSwitch.text = "Reminder enabled"
            userDefaults.setValue("true", forKey: "switchReminderState")
        }
    }
    
    
    
    //Listener Change Time Reminder Button
    @IBAction func onclickChangeTime(sender: AnyObject) {
        userDefaults.setValue(strDateShort, forKey: "timeReminder")
         let valueSwitch:String? = userDefaults.valueForKey("switchReminderState") as? String
        if(valueSwitch == "false")
        {
            userDefaults.setValue("true", forKey: "switchReminderState")
            switchReminder.setOn(true,animated:true)
            labelSwitch.text = "Reminder enabled"
        }
        refreshLabel()
        deletePreviousNotifications()
        setupAllNotifications()
    }
    
    func deletePreviousNotifications()
    {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    //Prepare all notifications
    func setupAllNotifications()
    {
        launchAlert(DateLong!)
        var currentDate = DateLong
        let components = NSDateComponents()
            components.day = 1
        for(var i = 1;i < 10;i++){
        currentDate =  NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: currentDate!, options: nil)
        launchAlert(currentDate!)
        }
    }
    
    //Launch Single alert
    func launchAlert(date:NSDate)
    {
        let valueSwitch:String? = userDefaults.valueForKey("switchReminderState") as? String
        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Notification App"
        localNotification.alertBody = "Please don't forget to ring for Internship"
        localNotification.fireDate = date
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    
    func getStringFromDate(date: NSDate) -> NSString
    {
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        return dateFormatter.stringFromDate(date)
    }
    
    //TODO DELETE
    @IBAction func onClickLog(sender: AnyObject) {
        println(UIApplication.sharedApplication().scheduledLocalNotifications)
    }
    
}
