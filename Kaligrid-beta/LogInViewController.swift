//
//  LogInViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/23/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit
import AWSMobileHubHelper
import AWSDynamoDB

var LOG_TAG = [String]();

class LogInViewController: UIViewController {
    
    var didSignInObserver: AnyObject? = nil
    var isRegistered = false
    
    @IBOutlet weak var facebookLogInButton: UIButton!
    @IBOutlet weak var googleLogInButton: UIButton!
    @IBAction func facebookLogInAction(sender: AnyObject) {
        self.handleLoginWithSignInProvider(AWSFacebookSignInProvider.sharedInstance())
    }
    
    @IBAction func googleLogInAction(sender: AnyObject) {
        self.handleLoginWithSignInProvider(AWSGoogleSignInProvider.sharedInstance())
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        CGRectMake()
        
        weak var weakSelf: LogInViewController? = self
        
        
        
        self.didSignInObserver = NSNotificationCenter.defaultCenter().addObserverForName(AWSIdentityManagerDidSignInNotification, object: AWSIdentityManager.defaultIdentityManager(), queue: NSOperationQueue.mainQueue(), usingBlock: {(note: NSNotification) -> Void in
            let weakSelfVC = weakSelf?.presentingViewController
            if weakSelfVC != nil{
                weakSelfVC!.dismissViewControllerAnimated(true, completion:nil)
            }
        })
        
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self.didSignInObserver!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        leaveLogInpage();
    }
    
    
    func handleGoogleLogin() {
        self.handleLoginWithSignInProvider(AWSGoogleSignInProvider.sharedInstance())
    }
    
    func handleFacebookLogin() {
        self.handleLoginWithSignInProvider(AWSFacebookSignInProvider.sharedInstance())
    }
    
    
    func handleLoginWithSignInProvider(signInProvider: AWSSignInProvider) {
        AWSIdentityManager.defaultIdentityManager().loginWithSignInProvider(signInProvider, completionHandler:
            {(result: AnyObject?, error: NSError?)-> Void in
                if (error == nil) {
                    //self.performSegueWithIdentifier("login", sender:self)
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        //self.dismissViewControllerAnimated(true, completion: { _ in })
                        //self.parentViewController!.dismissViewControllerAnimated(true, completion:nil)
                        //self.presentViewController(self, animated: true, completion:nil)
                        self.leaveLogInpage()
                        
                    })
                }
                
                print("result = \(result), error= \(error)")
        })
    }
    
    // Set background image
    func assignbackground(){
        let background = UIImage(named: "login_background_main")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    // Set button alignment
    func CGRectMake() {
        facebookLogInButton.setImage(UIImage(named: "icon_login_facebook.png"), forState: .Normal)
        facebookLogInButton.setTitle("Sign in with Facebook", forState: .Normal)
        facebookLogInButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 41.0, 0.0, 0.0)
        facebookLogInButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 115, 0.0, 0.0)
        facebookLogInButton.contentHorizontalAlignment = .Left
        self.view!.addSubview(facebookLogInButton)
        
        googleLogInButton.setImage(UIImage(named: "icon_login_google.png"), forState: .Normal)
        googleLogInButton.setTitle("Sign in with Google", forState: .Normal)
        googleLogInButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 41.0, 0.0, 0.0)
        googleLogInButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 120, 0.0, 0.0)
        googleLogInButton.contentHorizontalAlignment = .Left
        self.view!.addSubview(googleLogInButton)
    }
    
    func leaveLogInpage(){
        let strId   = AWSIdentityManager.defaultIdentityManager().identityId
        if !(strId==nil) && AWSIdentityManager.defaultIdentityManager().loggedIn{
            self.checkifUserRegistred(strId!)
            
            if self.isRegistered{
                self.performSegueWithIdentifier("login", sender:self)
            }else{
                self.performSegueWithIdentifier("register", sender:self)
            }
        }
    }
    
    // Check if a user is registered or not.
    func checkifUserRegistred(userid: String) {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        let task = dynamoDBObjectMapper .load(DDBUserRow.self, hashKey: userid, rangeKey: nil) as AWSTask!
        
        
        if (task.error == nil) {
            if (task.result != nil ){
            self.isRegistered = true
            }else{
                self.isRegistered = true // Fix this.. Figure out what the problem is... :(
            }
            
        } else {
            self.isRegistered = false
        }
        
        
        //
        //        dynamoDBObjectMapper .load(DDBUserRow.self, hashKey: userid, rangeKey: nil)
        //            .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
        //            if (task.error == nil) {
        //                print("Start Getting Row from User Table")
        //                self.isRegistered = true
        //
        //            } else {
        //                               self.isRegistered = false
        //                print("Error: \(task.error)")
        //                let alertController = UIAlertController(title: "Failed to get item from table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
        //                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
        //                })
        //                alertController.addAction(okAction)
        //                self.presentViewController(alertController, animated: true, completion: nil)
        //            }
        //                print("End Getting Row from User Table")
        //            return nil
        //        })
    }
}