//
//  CommentViewModel.swift
//  instagramClone
//
//  Created by 김민규 on 10/10/24.
//

import Foundation

@Observable
class CommentViewModel {
    var comments: [Comment] = []
    var postId: String
    var postuserId: String
    
    init(post: Post) {
        self.postId = post.id
        self.postuserId = post.userId
        Task {
            await loadComment()
        }
    }
    
    func uploadComment(commentText: String) async {
        guard let userId  = AuthManager.shared.currentUser?.id else { return }
        let comment = Comment(id: UUID().uuidString, commentText: commentText, postId: postId, postUserId: postuserId, commentUserId: userId, date: Date())
        await CommentManager.uploadComment(comment: comment, postId: postId)
        await loadComment()
    }
    
    func loadComment() async {
        self.comments = await CommentManager.loadComment(postId: postId)
        for i in 0..<comments.count {
            let user = await AuthManager.shared.loadUserData(userId: comments[i].commentUserId)
            comments[i].commentUser = user
        }
    }
}
