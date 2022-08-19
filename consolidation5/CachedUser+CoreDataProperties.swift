//
//  CachedUser+CoreDataProperties.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 19/08/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends_: NSSet?

}

// MARK: Generated accessors for friends_
extension CachedUser {

    @objc(addFriends_Object:)
    @NSManaged public func addToFriends_(_ value: CachedUser)

    @objc(removeFriends_Object:)
    @NSManaged public func removeFromFriends_(_ value: CachedUser)

    @objc(addFriends_:)
    @NSManaged public func addToFriends_(_ values: NSSet)

    @objc(removeFriends_:)
    @NSManaged public func removeFromFriends_(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
