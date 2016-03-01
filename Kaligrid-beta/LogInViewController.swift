//
//  LogInViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/23/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var usernameOutlet: UITextField!

    @IBOutlet weak var instructionOutlet: UILabel!
    
    @IBAction func facebookAction(sender: AnyObject) {
    }
    
    @IBAction func googleAction(sender: AnyObject) {
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        // TODO: Check if username/password combination is correct
        if usernameOutlet.text == "danielkim116" && passwordOutlet.text == "welcome"{
        self.performSegueWithIdentifier("login", sender:self)
        } else{
            instructionOutlet.text="Wrong! Enter Again"
        }
        // END OF TODO
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(animated: Bool) {
        // TODO: if logged in, automatically go to view
        if true{
        self.performSegueWithIdentifier("login", sender:self)
        }
        // END OF TODO
        
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
