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
            VStack {
//                GeometryReader { geometry in
//                    ZStack {
//                        Circle()
//                            .frame(height: geometry.size.height)
//                            .foregroundColor(Color.secondary)
//                        Text("G")
//                            .font(.custom("Georgia", size: geometry.size.height*0.5))
//                            .foregroundColor(Color.primary)
//                    }
//                }
//                .frame(maxHeight: 100)
                
                Text(user.name)
                    .font(.largeTitle)
                Text("\(user.age) Years Old")
                    .font(.subheadline)
            }
            
            ScrollView {
                groupEntriesView(content: [contactEntry(key: "Company", value: user.company),
                                           contactEntry(key: "Address", value: user.address),
                                           contactEntry(key: "Email", value: user.email)])
                
                groupEntriesView(content: [contactEntry(key: "Join Date", value: user.registered.formatted(date: .complete, time: .omitted)),
                                           contactEntry(key: "About", value: user.about)])
                
                // section friends list
                HStack {
                    VStack (alignment: .leading) {
                        Text("Friends")
                            .font(.headline.bold())
                        ForEach(user.friends) { friend in
                            RectangleDivider()
                            Text(friend.name)
                                .foregroundColor(.primary.opacity(0.7))
                        }
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary.opacity(0.2)).shadow(radius: 1))
                .padding()
            }
        }
        .navigationTitle("Contact Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: "123345", isActive: true, name: "Gustavo Verdugo", age: 20, company: "BestApp Company", email: "superman@bestapp.com", address: "12 main St", about: "Best dude ever, so much fun and so hansome. OMG I just can't", registered: Date.now, tags: ["hunky", "smart", "visionary"], friends: [Friend(id: "293849", name: "Daan the Man"), Friend(id: "666", name: "Keanu Reeves")]))
    }
}
