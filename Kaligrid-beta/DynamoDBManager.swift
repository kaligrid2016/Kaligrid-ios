//
//  DynamoDBManager.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 3/19/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import Foundation
import AWSDynamoDB

class DDBUserRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var UserId:String?
    var PhoneNumber:String?
    var DisplayName:String?
    var emailAddress:String?
    
    var AllowNameSearch:String? = "Y"
    var AllowIDSearch:String? = "Y"
    var AllowPhoneNumSearch:String? = "Y"
    var AllowEmailAddressSearch:String? = "Y"
    var ViewLevel:NSNumber? = 1

    
    class func dynamoDBTableName() -> String! {
        return DDBUserTableName
    }
    
    class func hashKeyAttribute() -> String! {
        return "UserId"
    }

    
    //MARK: NSObjectProtocol hack
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
}


class DDBEventRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var UserId:String?
    var EventId:String? =  "\(NSDate().timeIntervalSince1970)"  // TODO: Set this to unique ID
    var EventsName:String?
    var StartTime:String?
    var EndTime:String?
    var isAllDay:String? = "Y"
    var eventType:String? = "\(DDBEventRowType.Event.rawValue)"
    var location:String?
    
    class func dynamoDBTableName() -> String! {
        return DDBEventsTableName
    }
    
    class func hashKeyAttribute() -> String! {
        return "UserId"
    }
    
    class func rangeKeyAttribute() -> String! {
        return "EventId"
    }
    
    //MARK: NSObjectProtocol hack
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
}

class DDBEventInvitationRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var OrganizerUserId:String?
    var InviteeUserId:String?
    var EventId:String? // TODO: Set this to unique ID
    
    
    class func dynamoDBTableName() -> String! {
        return DDBEventInvitationTableName
    }
    
    class func hashKeyAttribute() -> String! {
        return "EventId"
    }
    
    class func rangeKeyAttribute() -> String! {
        return "InviteeUserId"
    }
    
    //MARK: NSObjectProtocol hack
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
}