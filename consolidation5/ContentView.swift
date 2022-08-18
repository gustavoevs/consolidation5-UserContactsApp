//
//  ContentView.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 09/08/2022.
//

import SwiftUI

struct ContentView: View {
    var model: Model
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink {
                    UserView(user: user)
                } label: {
                    HStack {
                        Text(user.wrappedName)
                        Spacer()
                        HStack {
                            Text(user.isActive ? "Online" : "Offline")
                                .font(.footnote)
                            Circle()
                                .foregroundColor(user.isActive ? .green : .red)
                                .frame(width: 10)
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}
