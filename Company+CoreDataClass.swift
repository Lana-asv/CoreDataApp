//
//  Company+CoreDataClass.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//
//

import Foundation
import CoreData


public class Company: NSManagedObject {

}

extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String
    @NSManaged public var uid: UUID
    @NSManaged public var date: Date
    @NSManaged public var staff: NSSet?

}

// MARK: Generated accessors for staff
extension Company {

    @objc(addStaffObject:)
    @NSManaged public func addToStaff(_ value: Person)

    @objc(removeStaffObject:)
    @NSManaged public func removeFromStaff(_ value: Person)

    @objc(addStaff:)
    @NSManaged public func addToStaff(_ values: NSSet)

    @objc(removeStaff:)
    @NSManaged public func removeFromStaff(_ values: NSSet)

}

extension Company : Identifiable {

}
