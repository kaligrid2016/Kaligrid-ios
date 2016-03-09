//
//  FirstViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/21/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit
import FSCalendar

class FirstViewController: UIViewController, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var listTable: UITableView!
    @IBAction func addButton(sender: AnyObject) {
    }
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bottom Tab Bar Controller
        let customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_bottom_list.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon_bottom_list_selected.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
        
        // Calendar Appearance
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        self.calendar.appearance.weekdayTextColor = UIColor(red: 0.031, green: 0.727, blue: 0.729, alpha: 1.0)
        self.calendar.appearance.weekdayFont = UIFont(name: "HelveticaNeue-Medium", size: 16)
        self.calendar.appearance.headerTitleColor = UIColor(red: 0.439, green: 0.431, blue: 0.431, alpha: 1.0)
        self.calendar.appearance.headerTitleFont = UIFont(name: "HelveticaNeue-Bold", size: 16)
        //self.calendar.appearance.eventColor = UIColor.greenColor()
        //self.calendar.appearance.selectionColor = UIColor.blueColor()
        self.calendar.appearance.todayColor = UIColor(red: 0.031, green: 0.729, blue: 0.729, alpha: 1.0)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

