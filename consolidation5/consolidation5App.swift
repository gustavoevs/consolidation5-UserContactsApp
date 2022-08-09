//
//  consolidation5App.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 09/08/2022.
//

import SwiftUI

@main
struct consolidation5App: App {
    private let model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
