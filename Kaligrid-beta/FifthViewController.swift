//
//  FifthViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/23/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {

   /* @IBOutlet weak var usernameOutlet: UILabel!
    @IBAction func logoutAction(sender: AnyObject) {
        self.handleLogout()
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        // Tab bar controller
        let customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_bottom_me.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon_bottom_me_selected.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
        removeTabbarItemText()
    }
    
    func removeTabbarItemText() {
        self.tabBarItem.title = ""
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
    }
/*
    override func viewWillAppear(animated: Bool) {
        let strName = AWSIdentityManager.sharedInstance().userName
        if (strName != nil) {
            self.usernameOutlet.text = strName
        }
        else {
            self.usernameOutlet.text = "GUEST USER"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLogout() {
        if AWSIdentityManager.sharedInstance().loggedIn {
            AWSIdentityManager.sharedInstance().logoutWithCompletionHandler({(result: AnyObject!, error: NSError!)  in
                self.performSegueWithIdentifier("logout", sender:self)
            })
            //NSLog(@"%@: %@ Logout Successful", LOG_TAG, [signInProvider getDisplayName]);
        }
        else {
            assert(false)
        }
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
