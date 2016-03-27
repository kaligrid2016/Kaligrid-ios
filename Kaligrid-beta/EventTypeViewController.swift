//
//  EventTypeViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 3/25/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class EventTypeViewController: UIViewController {

    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var eventButtonOutlet: UIButton!
    @IBOutlet weak var reminderButtonOutlet: UIButton!
    @IBOutlet weak var fyiButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Draw the cancel button
        self.cancelButtonOutlet.frame = CGRectMake(0, 0, 36, 36)
        self.cancelButtonOutlet.layer.cornerRadius = 0.5 * self.cancelButtonOutlet.bounds.size.width
        self.cancelButtonOutlet.backgroundColor = UIColor(red: 208/225, green: 208/225, blue: 208/225, alpha: 1.0)
        self.cancelButtonOutlet.setImage(UIImage(named:"icon_new_cancel.png"), forState: .Normal)
        
        // Draw the event button
        self.eventButtonOutlet.frame = CGRectMake(0, 0, 36, 36)
        self.eventButtonOutlet.layer.cornerRadius = 0.5 * self.eventButtonOutlet.bounds.size.width
        self.eventButtonOutlet.backgroundColor = UIColor(red: 245/225, green: 166/225, blue: 35/225, alpha: 1.0)
        self.eventButtonOutlet.setImage(UIImage(named:"icon_new_event.png"), forState: .Normal)
        
        // Draw the reminder button
        self.reminderButtonOutlet.frame = CGRectMake(0, 0, 36, 36)
        self.reminderButtonOutlet.layer.cornerRadius = 0.5 * self.reminderButtonOutlet.bounds.size.width
        self.reminderButtonOutlet.backgroundColor = UIColor(red: 251/225, green: 52/225, blue: 76/225, alpha: 1.0)
        self.reminderButtonOutlet.setImage(UIImage(named:"icon_new_reminder.png"), forState: .Normal)
        
        // Draw the FYI button
        self.fyiButtonOutlet.frame = CGRectMake(0, 0, 36, 36)
        self.fyiButtonOutlet.layer.cornerRadius = 0.5 * self.fyiButtonOutlet.bounds.size.width
        self.fyiButtonOutlet.backgroundColor = UIColor(red: 153/225, green: 195/225, blue: 243/225, alpha: 1.0)
        self.fyiButtonOutlet.setImage(UIImage(named:"icon_new_reminder.png"), forState: .Normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        
    
}
