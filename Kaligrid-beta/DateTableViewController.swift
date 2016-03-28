//
//  DateTableViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 3/3/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class DateTableViewController: UITableViewController {

    @IBOutlet weak var fromDetail: UILabel!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBAction func fromDatePickerValue(sender: AnyObject) {
        fromDatePickerChanged()
    }
    
    @IBOutlet weak var toDetail: UILabel!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBAction func toDatePickerValue(sender: AnyObject) {
        toDatePickerChanged()
    }
    
    @IBOutlet weak var alldaySwitchOutlet: UISwitch!
    @IBOutlet weak var reminderSwitchOutlet: UISwitch!
    
    func fromDatePickerChanged () {
        fromDetail.text = NSDateFormatter.localizedStringFromDate(fromDatePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    func toDatePickerChanged () {
        toDetail.text = NSDateFormatter.localizedStringFromDate(fromDatePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionFooterHeight = 12.0;
        self.tableView.backgroundColor = UIColor.whiteColor()
        fromDatePickerChanged()
        toDatePickerChanged()
        
        self.alldaySwitchOutlet.tintColor = UIColor(red: 250/225, green: 211/225, blue:145/225, alpha: 1.0)
        self.alldaySwitchOutlet.onTintColor = UIColor(red: 245/225, green: 166/225, blue: 35/225, alpha: 1.0)
        self.reminderSwitchOutlet.tintColor = UIColor(red: 250/225, green: 211/225, blue:145/225, alpha: 1.0)
        self.reminderSwitchOutlet.onTintColor = UIColor(red: 245/225, green: 166/225, blue: 35/225, alpha: 1.0)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            fromToggleDatepicker()
        }
        if indexPath.section == 0 && indexPath.row == 3 {
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
        
        if fromDatePickerHidden && indexPath.section == 0 && indexPath.row == 2{
            return 0
        }
        else {
            if toDatePickerHidden && indexPath.section == 0 && indexPath.row == 4{
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

    // MARK: - Table view data source

/*    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
