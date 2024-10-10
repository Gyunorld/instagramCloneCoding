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
    var commentCount = 0
    
    init(post: Post) {
        self.post = post
        Task {
            await loadUserData()
            await checkLike()
            await loadCommentCount()
        }
    }
    
    func loadUserData() async{
        let userId = post.userId
        guard let user = await AuthManager.shared.loadUserData(userId: userId) else { return }
        post.user = user
    }
}

extension FeedCellViewModel {
    func like() async {
        await PostManager.like(post: post)
        post.isLike = true
        post.like += 1
    }
    
    func unlike() async {
        await PostManager.like(post: post)
        post.isLike = false
        post.like -= 1
    }
    
    func checkLike() async {
        post.isLike = await PostManager.checkLike(post: post)
    }
}

extension FeedCellViewModel {
    func loadCommentCount() async {
        let postId = post.id
        self.commentCount = await CommentManager.loadCommentCount(postId: postId)
    }
}
