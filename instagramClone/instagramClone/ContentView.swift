//
//  ContentView.swift
//  instagramClone
//
//  Created by 김민규 on 9/27/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var signupViewModel = SignupViewModel()
    
    var body: some View {
        if AuthManager.shared.currentUser == nil {
            LoginView()
                .environment(signupViewModel)
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
