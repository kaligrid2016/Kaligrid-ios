//
//  SecondViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/21/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        // Tab bar controller
        let customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_bottom_grid.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon_bottom_grid_selected.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

