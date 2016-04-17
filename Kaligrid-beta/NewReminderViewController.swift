//
//  NewReminderViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 4/17/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit
import AWSMobileHubHelper
import AWSDynamoDB

class NewReminderViewController: UIViewController {
    @IBOutlet weak var eventTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle.setReminderBottomBorder()
        
    }
    
}

extension UITextField
{
    func setReminderBottomBorder(){
        self.borderStyle = UITextBorderStyle.None;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 251/225, green: 52/225, blue: 76/225, alpha: 1.0).CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
