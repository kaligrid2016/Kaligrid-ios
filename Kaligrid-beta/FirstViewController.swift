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
    
    var eventRows:Array<DDBEventRow>?
    var lastEvaluatedKey:[NSObject : AnyObject]!
    var  doneLoading = false
    var lock:NSLock?
    
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
        
        // Preparation for Event Rows
        eventRows = []
        lock = NSLock()
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
        
        self.refreshList(true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToFirstViewController (sender: UIStoryboardSegue){
        self.refreshList(true)
    }
    
    // A function that gets a particular row
    func getAllEentRows(userid: String) {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        dynamoDBObjectMapper .load(DDBEventRow.self, hashKey: userid, rangeKey: nil) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                // Do Nothing
            } else {
                print("Error: \(task.error)")
                let alertController = UIAlertController(title: "Failed to get item from table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            return nil
        })
    }
    
    func refreshList(startFromBeginning: Bool)  {
        if (self.lock?.tryLock() != nil) {
            if startFromBeginning {
                self.lastEvaluatedKey = nil;
                self.doneLoading = false
            }
            
            let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
            let queryExpression = AWSDynamoDBQueryExpression()
            queryExpression.hashKeyAttribute = "UserId"
            queryExpression.hashKeyValues = AWSIdentityManager.sharedInstance().identityId
            queryExpression.exclusiveStartKey = self.lastEvaluatedKey
            queryExpression.limit = 20;
            dynamoDBObjectMapper.query(DDBEventRow.self, expression: queryExpression).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
                
                if self.lastEvaluatedKey == nil {
                    self.eventRows?.removeAll(keepCapacity: true)
                }
                
                if task.result != nil {
                    let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                    for item in paginatedOutput.items as! [DDBEventRow] {
                        self.eventRows?.append(item)
                        print(item.EventsName)
                    }
                    
                    self.lastEvaluatedKey = paginatedOutput.lastEvaluatedKey
                    if paginatedOutput.lastEvaluatedKey == nil {
                        self.doneLoading = true
                    }
                }
                
                //self.tableView.reloadData()
                
                if ((task.error) != nil) {
                    print("Error: \(task.error)")
                }
                return nil
            })
        }
    }
    
    /*
    func accessEventRows(){
        for eachevent in self.eventRows! {
            let name = eachevent.EventsName
            let startdate = eachevent.StartTime
            let enddate = eachevent.EndTime
            
        }
        
    }*/
    
}

