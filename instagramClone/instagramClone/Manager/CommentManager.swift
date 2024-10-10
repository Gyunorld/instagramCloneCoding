//
//  CommentManager.swift
//  instagramClone
//
//  Created by 김민규 on 10/10/24.
//

import Foundation
import Firebase

class CommentManager {
    static func uploadComment(comment: Comment, postId: String) async {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        do {
            try await Firestore.firestore()
                .collection("posts")
                .document(postId)
                .collection("post-comment")
                .addDocument(data: commentData)
        } catch {
            print("Error uploading comment: \(error)")
        }
    }
    
    static func loadComment(postId: String) async -> [Comment] {
        do {
            let documents = try await Firestore.firestore()
                .collection("posts")
                .document(postId)
                .collection("post-comment")
                .order(by: "date", descending: true)
                .getDocuments()
                .documents
            let comments = documents.compactMap { document in
                try? document.data(as: Comment.self)
            }
            return comments
        } catch {
            print("Error loading comments: \(error)")
            return []
        }
    }
    
    static func loadCommentCount(postId: String) async -> Int {
        do {
            do {
                let documents = try await Firestore.firestore()
                    .collection("posts")
                    .document(postId)
                    .collection("post-comment")
                    .getDocuments()
                    .documents
                return documents.count
            } catch {
                print("Error loading comments count: \(error)")
                return 0
            }
        }
    }
}
