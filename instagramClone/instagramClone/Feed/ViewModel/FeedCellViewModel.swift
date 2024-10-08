//
//  FeedCellViewModel.swift
//  instagramClone
//
//  Created by 김민규 on 10/7/24.
//

import Foundation

@Observable
class FeedCellViewModel {
    var post: Post
    
    init(post: Post) {
        self.post = post
        Task {
            await loadUserData()
        }
    }
    
    func loadUserData() async{
        let userId = post.userId
        guard let user = await AuthManager.shared.loadUserData(userId: userId) else { return }
        post.user = user
    }
}
