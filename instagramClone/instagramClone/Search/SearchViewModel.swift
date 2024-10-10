//
//  SearchViewModel.swift
//  instagramClone
//
//  Created by 김민규 on 10/10/24.
//

import Foundation

@Observable
class SearchViewModel {
    var users: [User] = []
    
    init() {
        Task {
            await loadAllUserData()
        }
    }
    
    func loadAllUserData() async {
        self.users = await AuthManager.shared.loadAllUserData() ?? []
    }
}
