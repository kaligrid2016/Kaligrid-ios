//
//  DynamoDBManager.swift
//  Kaligrid-beta
//
//  Created by Kali Grid on 3/19/16.
//  Copyright © 2016 Kaligrid. All rights reserved.
//

import Foundation

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


