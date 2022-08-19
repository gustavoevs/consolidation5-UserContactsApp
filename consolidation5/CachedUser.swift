//
//  CachedUser.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 19/08/2022.
//

import Foundation
import CoreData

extension CachedUser {
    public var wrappedID: String {
        id ?? "Unknown ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    public var wrappedAbout: String {
        about ?? "No Details"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.distantPast
    }
    
    public var wrappedTags: String {
        tags ?? ""
    }

    public var friends: Set<CachedUser> {
        get { (friends_ as? Set<CachedUser>) ?? [] }
        set { friends_ = newValue as NSSet }
    }
}

extension CachedUser {
    // FetchCachedUserFromCoreData searches for a user with specific id in CoreData.
    // returns a CachedUser if found, nil if not
    static func fetchCachedUserFromCoreData(id: String, context: NSManagedObjectContext) -> CachedUser? {
        let request = NSFetchRequest<CachedUser>(entityName: "CachedUser")
        request.predicate = NSPredicate(format: "id = %@", id)
        request.sortDescriptors = []
        let user = (try? context.fetch(request))?.first ?? nil
        return user
    }
    
    // Takes a friend object (id and name only) and creates a placeholder CachedUser with
    //  those 2 fields in CoreData. If CachedUser already exists, simply return existing CachedUser.
    static func fetchFriend (friend: Friend, context: NSManagedObjectContext) -> CachedUser {
        if let user = fetchCachedUserFromCoreData(id: friend.id, context: context) {
            return user
        } else {
            // User not found. Create placeholder CachedUser
            let user = CachedUser(context: context)
            user.id = friend.id
            user.name = friend.name
            try? context.save()
            return user
        }
    }
        
    // Searches in CoreData for the user.id. If found, overwrite this user. If not, create new user.
    static func createUser (user: User, context: NSManagedObjectContext) -> CachedUser {
        let cachedUser = fetchCachedUserFromCoreData(id: user.id, context: context) ?? CachedUser(context: context)
        cachedUser.id = user.id
        cachedUser.isActive = user.isActive
        cachedUser.name = user.name
        cachedUser.age = Int16(user.age)
        cachedUser.company = user.company
        cachedUser.email = user.email
        cachedUser.address = user.address
        cachedUser.about = user.about
        cachedUser.registered = user.registered
        for friend in user.friends {
            cachedUser.friends.insert(fetchFriend(friend: friend, context: context))
        }
        try? context.save() // Probably should handle this somehow.
        return cachedUser
    }
}
