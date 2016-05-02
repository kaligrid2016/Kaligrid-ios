//
//  SettingsViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 3/8/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit
import AWSMobileHubHelper
import AWSDynamoDB

class AccountSettingsViewController: UIViewController {
    
    @IBOutlet weak var displayNameOutlet: UITextField!
    @IBOutlet weak var emailAddressOutlet: UITextField!
    @IBOutlet weak var phoneNumberOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var profilePIcture: UIImageView!
    
    var tableRow:DDBUserRow?
    
    
    
    @IBAction func logoutAction(sender: AnyObject) {
        self.handleLogout()
        exit(0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveAccountSetting" {
            self.tableRow!.UserId = AWSIdentityManager.defaultIdentityManager().identityId
            self.tableRow!.DisplayName =   self.displayNameOutlet.text
            self.tableRow!.emailAddress = self.emailAddressOutlet.text
            self.tableRow!.PhoneNumber = self.phoneNumberOutlet.text
            
            if (self.phoneNumberOutlet.text!.utf16.count > 0) {
                self.updateTableRow(tableRow!)
            } else {
                let alertController = UIAlertController(title: "Error: Invalid Input", message: "Phone Number cannot be empty.", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strId   = AWSIdentityManager.defaultIdentityManager().identityId
        self.getUserTableRow(strId!)
        
        let imageURL = AWSIdentityManager.defaultIdentityManager().imageURL
        let imageData = NSData(contentsOfURL: imageURL!)
        self.profilePIcture.image = UIImage(data: imageData!)
    }
    
    override func viewDidAppear(animated: Bool) {
        // Tab bar controller
        let customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_bottom_me.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon_bottom_me_selected.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // A function that handles Logout
    func handleLogout() {
        if AWSIdentityManager.defaultIdentityManager().loggedIn {
            AWSIdentityManager.defaultIdentityManager().logoutWithCompletionHandler({(result: AnyObject?, error: NSError?) -> Void in
                // self.performSegueWithIdentifier("logout", sender:self)
            })
            //NSLog(@"%@: %@ Logout Successful", LOG_TAG, [signInProvider getDisplayName]);
        }
        else {
            assert(false)
        }
    }
    
    // A function that gets a particular row
    func getUserTableRow(userid: String) {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        dynamoDBObjectMapper .load(DDBUserRow.self, hashKey: userid, rangeKey: nil) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                if (task.result != nil) {
                    self.tableRow = task.result as? DDBUserRow
                    
                    self.displayNameOutlet.text = self.tableRow!.DisplayName
                    self.emailAddressOutlet.text = self.tableRow!.emailAddress
                    self.phoneNumberOutlet.text = self.tableRow!.PhoneNumber
                    //self.passwordOutlet.text = AWSIdentityManager.sharedInstance().userName
                }
            } else {
                print("Error: \(task.error)")
                let alertController = UIAlertController(title: "Failed to get item from table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            return nil
        })
    }
    
    func updateTableRow(tableRow:DDBUserRow) {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        dynamoDBObjectMapper .save(tableRow) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                // Do Nothing
                
            } else {
                print("Error: \(task.error)")
                
                let alertController = UIAlertController(title: "Failed to update the data into the table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            return nil
        })
    }
    
    // TODO: Fix the following a lot and call this
    func createNewUserSettingRow(){

        let strName = AWSIdentityManager.defaultIdentityManager().userName
        if (strName != nil){
            self.displayNameOutlet.text = strName
        }
        else {
            self.displayNameOutlet.text = "GUEST USER"
        }
    }
    
    
}
