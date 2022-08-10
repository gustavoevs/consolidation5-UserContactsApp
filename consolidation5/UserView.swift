//
//  UserView.swift
//  consolidation5
//
//  Created by Gustavo Verdugo on 10/08/2022.
//

import SwiftUI

struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.secondary.opacity(0.5))
//            .padding(.bottom)
    }
}

struct contactEntry {
    var key: String
    var value: String
}

struct groupEntriesView: View {
    var content: [contactEntry]
    var body: some View {
        Group {
            HStack {
                VStack (alignment: .leading) {
                    ForEach(0..<content.count) { index in
                        Text(content[index].key)
                            .font(.subheadline.bold())
                        Text(content[index].value)
                            .foregroundColor(.primary.opacity(0.7))
                        if (index < content.count-1) {
                            RectangleDivider()
                        }
                    }
                }
                Spacer()
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .multilineTextAlignment(.leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary.opacity(0.2)).shadow(radius: 1))
        .padding()
    }
}

struct UserView: View {
    var user: User
    
    var body: some View {
        VStack {
//            Image("stefan-stefancik")
//                .resizable()
//                .frame(width: 200)
//                .clipShape(Circle())
//            // Too ambitious
            
            // Image
            // Name
            Text(user.name)
                .font(.largeTitle)
            
            Group {
                HStack {
                    Text(user.address)
                    Spacer()
                }
            }
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary.opacity(0.2)).shadow(radius: 1))
                .padding()
            
            groupEntriesView(content: [contactEntry(key: "Address", value: user.address),
                                       contactEntry(key: "Email", value: user.address)])
            
            // Company
            // active or not
            
            // Contact
                // email
                // address
            
            
            // section about
            // section join date
            
            // section friends list
            
        }
        .navigationTitle("Contact Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: "123345", isActive: true, name: "Gustavo Verdugo", age: 20, company: "BestApp Company", email: "superman@bestapp.com", address: "12 main St", about: "Best dude ever, so much fun and so hansome. OMG I just can't", registered: "12 August 2020", tags: ["hunky", "smart", "visionary"], friends: [Friend(id: "293849", name: "Daan the Man"), Friend(id: "666", name: "Keanu Reeves")]))
    }
}
