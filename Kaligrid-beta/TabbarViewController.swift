//
//  TabbarViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/25/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Load the bottom tab bar icons
        let image:NSArray = ["icon_bottom_list.png", "icon_bottom_grid.png", "icon_bottom_kali.png","icon_bottom_friends.png", "icon_bottom_me.png"]
        let selImage:NSArray = ["icon_bottom_list_selected.png", "icon_bottom_grid_selected.png", "icon_bottom_kali_selected.png","icon_bottom_friends_selected.png", "icon_bottom_me_selected.png"]
        
        for var i=0; i<image.count; i=1+i{
        let listSelectImage: UIImage! = UIImage(named: selImage[i] as! String)!.imageWithRenderingMode(.AlwaysOriginal)
        let listImage: UIImage! = UIImage(named: image[i] as! String)!.imageWithRenderingMode(.AlwaysOriginal)
            
        self.tabBar.items![i].selectedImage = listSelectImage
        self.tabBar.items![i].image = listImage
        self.tabBar.items![i].title = nil
        }
        // Set the tab bar background color
        UITabBar.appearance().barTintColor = UIColor.whiteColor()

        // Present LogIn page
        //self.presentSignInViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentSignInViewController() {
        
        if !AWSIdentityManager.sharedInstance().loggedIn {
            let storyboard: UIStoryboard = UIStoryboard(name: "LogIn", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LogIn")
            self.navigationController?.showViewController(vc, sender: nil)
  //          self.presentViewController(vc, animated: true, completion:nil )
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
