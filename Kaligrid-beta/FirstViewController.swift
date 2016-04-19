//
//  FirstViewController.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 2/21/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import UIKit
import FSCalendar
import AWSMobileHubHelper
import AWSDynamoDB

var eventRows:Array<DDBEventRow>?
//var invitedeventRows:Array<DDBEventRow>?

class FirstViewController: UIViewController, FSCalendarDataSource, UITableViewDelegate {
    
    var lastEvaluatedKey:[NSObject : AnyObject]!
    var  doneLoading = false
    var lock:NSLock?
    var oldDate = "merong"
    
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
        removeTabbarItemText()
        
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
        
        // Dynamic row height
        configureTableView()
        
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
    
    // set up list table
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (eventRows?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let eachevent = eventRows![indexPath.row]
        var dateAndTime = eachevent.StartTime?.componentsSeparatedByString(", ")
        let newDate = dateAndTime![0]
        if newDate != oldDate {
            let cellIdentifier = "DateCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DateCell
            cell.agendaDateOutlet.text = newDate
            cell.startTimeOutlet.text = dateAndTime![1]
            
            // set icon image
            if eachevent.eventType == "\(DDBEventRowType.Event.rawValue)"{
                cell.self.eventTypeIconOutlet.image = UIImage(named: "icon_front_event.png")
            }
            
            // diaplay event title
            cell.eventTitleOutlet.text = eachevent.EventsName
            
            // draw lines
            let shapeLayer: CAShapeLayer = CAShapeLayer.init()
            shapeLayer.bounds = cell.bounds
            shapeLayer.position = cell.center
            shapeLayer.fillColor = UIColor.clearColor().CGColor
            shapeLayer.strokeColor = UIColor(red: 112/225, green: 110/225, blue: 110/225, alpha: 1.0).CGColor
            shapeLayer.lineWidth = 0.5
            shapeLayer.lineJoin = kCALineJoinRound
            shapeLayer.lineDashPattern = [Int(3), Int(1)]
            let path: CGMutablePathRef = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 0, 0)
            CGPathAddLineToPoint(path, nil, cell.contentView.bounds.size.width, 0)
            shapeLayer.path = path
            cell.layer.addSublayer(shapeLayer)
            let shapeLayer2: CAShapeLayer = CAShapeLayer.init()
            shapeLayer2.bounds = cell.bounds
            shapeLayer2.position = cell.center
            shapeLayer2.fillColor = UIColor.clearColor().CGColor
            shapeLayer2.strokeColor = UIColor(red: 112/225, green: 110/225, blue: 110/225, alpha: 0.5).CGColor
            shapeLayer2.lineWidth = 0.5
            shapeLayer2.lineJoin = kCALineJoinRound
            shapeLayer2.lineDashPattern = [Int(3), Int(1)]
            let path2: CGMutablePathRef = CGPathCreateMutable()
            CGPathMoveToPoint(path2, nil, 0, 30)
            CGPathAddLineToPoint(path2, nil, cell.contentView.bounds.size.width, 30)
            shapeLayer2.path = path2
            cell.layer.addSublayer(shapeLayer2)
            
            
            oldDate = newDate
            return cell
            
        } else {
            let cellIdentifier = "BasicCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BasicCell
            
            // Configure the cell...
            // display time
            if eachevent.isAllDay == "Y" {
                cell.startTimeOutlet.text = "All-day"
            } else {
                cell.startTimeOutlet.text = dateAndTime![1]
            }
            
            // set icon image
            if eachevent.eventType == "\(DDBEventRowType.Event.rawValue)"{
                cell.self.eventTypeIconOutlet.image = UIImage(named: "icon_front_event.png")
            }
            
            // diaplay event title
            cell.eventTitleOutlet.text = eachevent.EventsName
            return cell
        }
        
    }
    
    //dynamic row height
    func configureTableView() {
        listTable.rowHeight = UITableViewAutomaticDimension
        listTable.estimatedRowHeight = 36.0
    }
    
    override func viewDidAppear(animated: Bool) {
        listTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToFirstViewController (sender: UIStoryboardSegue){
        self.refreshList(true)
        listTable.reloadData()
        
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
            
            // Populate eventRow (the user-created events)
            let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
            let queryExpression = AWSDynamoDBQueryExpression()
            queryExpression.hashKeyAttribute = "UserId"
            queryExpression.hashKeyValues = AWSIdentityManager.defaultIdentityManager().identityId
            queryExpression.exclusiveStartKey = self.lastEvaluatedKey
            //queryExpression.limit = 20;
            dynamoDBObjectMapper.query(DDBEventRow.self, expression: queryExpression).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
                
                if self.lastEvaluatedKey == nil {
                    eventRows?.removeAll(keepCapacity: true)
                }
                
                if task.result != nil {
                    let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                    for item in paginatedOutput.items as! [DDBEventRow] {
                        eventRows?.append(item)
                        print(item.EventsName)
                    }
                    
                }
                
                self.listTable.reloadData()
                
                if ((task.error) != nil) {
                    print("Error: \(task.error)")
                }
                
                // Populate eventRow (the events that invited users)
                let queryInviteExpression = AWSDynamoDBScanExpression()
                
                // TODO: Uncomment the following out.
                
                
                var useridstring = ""
                if AWSIdentityManager.defaultIdentityManager().identityId == "us-east-1:1583d60f-531d-459d-b42f-36dab3a93d85"{
                    useridstring = "kgbisa"
                }else{
                    useridstring = "danielkim116"
                }
                
                
                queryInviteExpression.filterExpression = "InviteeUserId = :val1 and OrganizerUserId <> :val2"
                queryInviteExpression.expressionAttributeValues = [":val1": useridstring, ":val2": useridstring]
                
                //queryInviteExpression.hashKeyValues = AWSIdentityManager.defaultIdentityManager().identityId
                dynamoDBObjectMapper.scan(DDBEventInvitationRow.self, expression: queryInviteExpression).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (taskEventInvite:AWSTask!) -> AnyObject! in
                    
                    if taskEventInvite.result != nil {
                        let paginatedInvite = taskEventInvite.result as! AWSDynamoDBPaginatedOutput
                        for invitationrow in paginatedInvite.items as! [DDBEventInvitationRow] {
                            
                            let queryinvitedEventExpression = AWSDynamoDBScanExpression()
                            queryinvitedEventExpression.filterExpression = "EventId = :val1"
                            queryinvitedEventExpression.expressionAttributeValues = [":val1": invitationrow.EventId!]
                            
                            dynamoDBObjectMapper.scan(DDBEventRow.self, expression: queryinvitedEventExpression).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (taskInvitation:AWSTask!) -> AnyObject! in
                                
                                if taskInvitation.result != nil {
                                    let myinvitations = taskInvitation.result as! AWSDynamoDBPaginatedOutput
                                    
                                    for invitationevent in myinvitations.items as! [DDBEventRow]{
                                        eventRows?.append(invitationevent)
                                        print(invitationevent.EventsName)
                                    }
                                    
                                }
                                self.listTable.reloadData()
                                
                                if ((taskInvitation.error) != nil) {
                                    print("Error: \(taskInvitation.error)")
                                }
                                return nil
                            })
                        }
                        
                        self.lastEvaluatedKey = paginatedInvite.lastEvaluatedKey
                    }
                    
                    
                    if ((taskEventInvite.error) != nil) {
                        print("Error: \(taskEventInvite.error)")
                    }
                    
                    return nil
                })
                
                
                return nil
            })
            
            
        }
    }
    
    func removeTabbarItemText() {
        self.tabBarItem.title = ""
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
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

