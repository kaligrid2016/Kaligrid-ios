//
//  NewEventViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 3/3/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit
import AWSMobileHubHelper
import AWSDynamoDB

class NewEventViewController: UIViewController {
    
    @IBOutlet weak var eventTitle: UITextField!
    //@IBAction func addAction(sender: AnyObject) {
    //}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle.setEventBottomBorder()

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveNewEvent" {
            let eventRow = DDBEventRow()
            eventRow!.UserId=AWSIdentityManager.defaultIdentityManager().identityId
            eventRow!.EventsName = self.eventTitle.text
            eventRow!.isAllDay = isAllDayFromDateTable
            eventRow!.StartTime = fromtimeFromDateTable
            eventRow!.EndTime = totimeFromDateTable
            
            
            // Do this for a list of invitations. For now, I allow to invite only one person
            let invitationRow = DDBEventInvitationRow()
            invitationRow!.OrganizerUesrId = eventRow!.UserId
            //invitationRow!.InviteeUserId = invitationList
            invitationRow!.InviteeUserId = "danielkim116"
            invitationRow!.EventId = eventRow!.EventId
        
            
            isAllDayFromDateTable="N"
            fromtimeFromDateTable=""
            totimeFromDateTable=""
            invitationList=""
            
            if !((self.eventTitle.text ?? "").isEmpty) {
                self.updateEventTableRow(eventRow!)
                
                if !((invitationRow.InviteeUserId ?? "").isEmpty){
                self.updateInvitationTableRow(invitationRow!)
                }
                
            } else {
                let alertController = UIAlertController(title: "Error: Invalid Input", message: "Event name cannot be empty.", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateEventTableRow(tableRow:DDBEventRow) {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        dynamoDBObjectMapper .save(tableRow) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                // Do Nothing
                
            } else {
                print("Error: \(task.error)")
                
                let alertController = UIAlertController(title: "Failed to update the event data into the table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            return nil
        })
    }
    
    func updateInvitationTableRow(tableRow:DDBEventInvitationRow) {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        dynamoDBObjectMapper .save(tableRow) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                // Do Nothing
                
            } else {
                print("Error: \(task.error)")
                
                let alertController = UIAlertController(title: "Failed to update the invitation data into the table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            return nil
        })
    }
}

extension UITextField
{
    func setEventBottomBorder(){
        self.borderStyle = UITextBorderStyle.None;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 245/225, green: 166/225, blue: 35/225, alpha: 1.0).CGColor

        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
