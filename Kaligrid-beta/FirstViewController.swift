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
    

    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var addButtonLook: UIButton!
    @IBAction func addButton(sender: AnyObject) {
    }
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
        
        // Calendar mode
        
        self.calendar.focusOnSingleSelectedDate = true
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureUp:")
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureDown:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeUp)
        self.view.addGestureRecognizer(swipeDown)
        
        // Draw the add button
        self.addButtonLook.frame = CGRectMake(0, 0, 36, 36)
        self.addButtonLook.layer.cornerRadius = 0.5 * self.addButtonLook.bounds.size.width
        self.addButtonLook.backgroundColor = UIColor(red: 0.031, green: 0.729, blue: 0.729, alpha: 1.0)
        self.addButtonLook.setImage(UIImage(named:"icon_new.png"), forState: .Normal)
    }
    
    func respondToSwipeGestureUp(gesture: UIGestureRecognizer) {
        self.calendar.setScope(.Week, animated: true)
        calendarHeightConstraint.constant = 75.0
    }
    
    func respondToSwipeGestureDown(gesture: UIGestureRecognizer) {
        self.calendar.setScope(.Month, animated: true)
        calendarHeightConstraint.constant = 200.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToFirstViewController (sender: UIStoryboardSegue){
    }


}

