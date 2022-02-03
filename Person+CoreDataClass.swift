//
//  Person+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//
//

import Foundation
import CoreData


public class Person: NSManagedObject {

}

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String
    @NSManaged public var age: String
    @NSManaged public var date: Date
    @NSManaged public var experince: String?
    @NSManaged public var company: Company
    @NSManaged public var uid: UUID

}

extension Person : Identifiable {

}
