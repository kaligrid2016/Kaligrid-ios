//
//  LogInViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/23/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit
import AWSMobileHubHelper

var LOG_TAG = [String]();

class LogInViewController: UIViewController {
    
    var didSignInObserver: AnyObject? = nil
    
    @IBAction func googleLogInAction(sender: AnyObject) {
                    self.handleLoginWithSignInProvider(AWSGoogleSignInProvider.sharedInstance())
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if AWSIdentityManager.defaultIdentityManager().loggedIn{
          self.performSegueWithIdentifier("login", sender:self)
        }
        
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
 
                })
            }
            
                print("result = \(result), error= \(error)")
        })
    }
}