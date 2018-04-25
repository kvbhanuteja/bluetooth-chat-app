//
//  SignUp+CoreDataProperties.swift
//  patymDemo
//
//  Created by Bhanuteja on 28/04/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import Foundation
import CoreData


extension SignUp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SignUp> {
        return NSFetchRequest<SignUp>(entityName: "SignUp")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var emailId: String?
    @NSManaged public var country: String?
    @NSManaged public var pincode: String?
    @NSManaged public var state: String?

}
