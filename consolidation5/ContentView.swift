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
        NavigationView {
            List(model.users, id: \.id) { user in
                NavigationLink {
                    UserView(user: user)
                } label: {
                    HStack {
                        Text(user.name)
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
