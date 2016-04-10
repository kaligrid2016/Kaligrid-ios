//
//  ThirdViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/23/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Tab bar controller
        let customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_bottom_kali.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon_bottom_kali_selected.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
        removeTabbarItemText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeTabbarItemText() {
        self.tabBarItem.title = ""
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
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
