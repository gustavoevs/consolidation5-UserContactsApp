//
//  Model.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 09/08/2022.
//

import Foundation
import FileProvider
import CoreData

// Way this works:
// init will attempt to load data from web.
//  if success, store data to CoreData
//  if fail, attempt to load data from CoreData
//      if fail, terminate program

class Model: ObservableObject {
    @Published public var users: [User]
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            } else {
                fatalError("Failed to decode JSON")
            }
        } catch {
            print("Invalid data")
        }
    }
    
    init() {
        users = [User]()
        Task() {
            await loadData()
        }
    }
}


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataModel")
    private var usersDataFromJSON: [User]
    
    enum DataLoadError: Error {
        case InvalidURL
        case FailedDecodingJSON
        case URLSessionError
        case CoreDataFailLoad
        case CoreDataSaveFail
    }
    
    func loadDataFromURL() async throws {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            throw DataLoadError.InvalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                usersDataFromJSON = decodedResponse
            } else {
                throw DataLoadError.FailedDecodingJSON
            }
        } catch {
            throw DataLoadError.URLSessionError
        }
    }
    
    
    // This function is ugly but really didn't know how to throw the error from inside the call to loadPersistentStores and moving on to other things.
    func initCoreData() throws {
        var throwError = false
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                throwError = true
                // Ideally we throw error here, but gets messed up by being inside a closure.
                //  not gonna try to figure this out for now.
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        if throwError {
            throw DataLoadError.CoreDataFailLoad
        }
    }
    
    func saveDataToCoreData(users: [User]) throws {
        for user in users {
            let mocUser = CachedUser(context: container.viewContext)
            mocUser.id = user.id
            mocUser.isActive = user.isActive
            mocUser.name = user.name
            mocUser.age = Int16(user.age)
            mocUser.company = user.company
            mocUser.email = user.email
            mocUser.address = user.address
            mocUser.about = user.about
            mocUser.registered = user.registered
            //mocUser.tags = user.tags // TODO: Deal with this later
            var friends = [CachedFriend]()
            for friend in user.friends {
                let mocFriend = CachedFriend(context: container.viewContext)
                mocFriend.id = friend.id
                mocFriend.name = friend.name
                friends.append(mocFriend)
            }
            mocUser.friends = NSSet(array: friends)
            try container.viewContext.save()
        }
    }
    
    // Seems like @FetchRequest not available outside Views
    // Solution is complex, so gonna finish this project and move on.
//    func loadDataFromCoreData() {
//
//    }
    
    // Way this works:
    // init will attempt to load data from web.
    //  if success, store data to CoreData
    //  if fail, attempt to load data from CoreData
    //      if fail, terminate program
    init() {
        usersDataFromJSON = [User]()
        do {
            try initCoreData()
        } catch {
            fatalError("Failed to Initialize CoreData")
        }
        Task() {
            do { // Load Data from Server
                try await loadDataFromURL()
                // Save to CoreData
                do {
                    try saveDataToCoreData(users: usersDataFromJSON)
                } catch {
                    fatalError("DataLoadError.CoreDataSaveFail")
                }
            } catch {
                print("Network Data Load Fail")
            }
            
            // Lading data from CoreData will be handled in View
//            loadDataFromCoreData()
        }
    }
}
