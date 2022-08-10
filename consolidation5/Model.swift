//
//  Model.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 09/08/2022.
//

import Foundation

class Model: ObservableObject {
    @Published public var users: [User]
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
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
