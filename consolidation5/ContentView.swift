//
//  ContentView.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 09/08/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: Model
    
    var body: some View {
        List(model.users, id: \.id) { user in
            Text(user.name)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}
