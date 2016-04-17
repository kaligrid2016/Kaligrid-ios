//
//  ReminderDateTableViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 4/17/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class ReminderDateTableViewController: UITableViewController {

    @IBOutlet weak var fromDetail: UILabel!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDetail: UILabel!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var alldaySwitchOutlet: UISwitch!
    @IBOutlet weak var reminderSwitchOutlet: UISwitch!
    @IBOutlet weak var reminderFriendsSwitchOutlet: UISwitch!
    
    func fromDatePickerChanged () {
        fromDetail.text = NSDateFormatter.localizedStringFromDate(fromDatePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        fromtimeFromDateTable = fromDetail.text!
    }
    
    func toDatePickerChanged () {
        toDetail.text = NSDateFormatter.localizedStringFromDate(fromDatePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        totimeFromDateTable = toDetail.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionFooterHeight = 0;
        self.tableView.backgroundColor = UIColor.whiteColor()
        fromDatePickerChanged()
        toDatePickerChanged()
        
        self.alldaySwitchOutlet.tintColor = UIColor(red: 242/225, green: 109/225, blue:125/225, alpha: 1.0)
        self.alldaySwitchOutlet.onTintColor = UIColor(red: 251/225, green: 52/225, blue: 76/225, alpha: 1.0)
        self.reminderSwitchOutlet.tintColor = UIColor(red: 242/225, green: 109/225, blue:125/225, alpha: 1.0)
        self.reminderSwitchOutlet.onTintColor = UIColor(red: 251/225, green: 52/225, blue: 76/225, alpha: 1.0)
        self.reminderFriendsSwitchOutlet.tintColor = UIColor(red: 242/225, green: 109/225, blue:125/225, alpha: 1.0)
        self.reminderFriendsSwitchOutlet.onTintColor = UIColor(red: 251/225, green: 52/225, blue: 76/225, alpha: 1.0)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Addition of Switches
        self.alldaySwitchOutlet.setOn(false, animated:true)
        self.alldaySwitchOutlet.addTarget(self, action: Selector("alldaystateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func alldaystateChanged(switchState: UISwitch) {
        if switchState.on {
            isAllDayFromDateTable = "Y"
        } else {
            isAllDayFromDateTable = "N"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            fromToggleDatepicker()
        }
        if indexPath.section == 0 && indexPath.row == 4 {
            toToggleDatepicker()
        }
    }
    /*
     override func toTableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     if indexPath.section == 0 && indexPath.row == 0 {
     toToggleDatepicker()
     }
     }*/
    
    var fromDatePickerHidden = true
    var toDatePickerHidden = true
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 16
            }
            if indexPath.row == 1 {
                return 38
            }
            if indexPath.row == 2 || indexPath.row == 4 {
                return 28
            }
            if indexPath.row == 6 || indexPath.row == 8 || indexPath.row == 10 {
                return 40
            }
            if indexPath.row == 7 || indexPath.row == 9 || indexPath.row == 11 {
                return 26
            }
        }
        
        if fromDatePickerHidden && indexPath.section == 0 && indexPath.row == 3{
            return 0
        }
        else {
            if toDatePickerHidden && indexPath.section == 0 && indexPath.row == 5{
                return 0
            }
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor(red: 245/225, green: 166/225, blue: 35/225, alpha: 1.0)
        header.textLabel!.font = UIFont.boldSystemFontOfSize(16)
        header.contentView.backgroundColor = UIColor.whiteColor()
    }
    
    
    /*
     override func toTableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
     if toDatePickerHidden && indexPath.section == 0 && indexPath.row == 1 {
     return 0
     }
     else {
     return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
     }
     }*/
    
    func fromToggleDatepicker() {
        
        fromDatePickerHidden = !fromDatePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    func toToggleDatepicker() {
        
        toDatePickerHidden = !toDatePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
}
