//
//  MainTabView.swift
//  instagramClone
//
//  Created by 김민규 on 9/27/24.
//

import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            Text("Feed")
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0) // tag로 이름 붙여주기
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            NewPostView(tabIndex: $tabIndex)
                .tabItem {
                    Image(systemName: "plus.square")
                }
                .tag(2)
            VStack {
                Text("Reels")
                Button {
                    AuthManager.shared.signout()
                } label: {
                    Text("로그아웃")
                }
            }
                    .tabItem {
                        Image(systemName: "movieclapper")
                    }
                    .tag(3)
//            Text("Profile")
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
                .tag(4)
        }
        .tint(Color.black)
    }
}

#Preview {
    MainTabView()
}
