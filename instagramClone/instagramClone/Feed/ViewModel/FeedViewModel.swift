//
//  FeedViewModel.swift
//  instagramClone
//
//  Created by 김민규 on 10/7/24.
//

import Foundation
import Firebase

@Observable
class FeedViewModel {
    
    var posts: [Post] = []
    
    init() {
        Task {
            await loadAllPosts()
            print("posts:",posts)
        }
    }
    
    func loadAllPosts() async {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true)
                .getDocuments().documents
            // 방법 1
            //                    var posts: [Post] = []
            //                    for document in documents {
            //                        let post = try document.data(as: Post.self)
            //                        posts.append(post)
            //                    }
            //                    self.posts = posts
            
            // 방법 2
            //                    self.posts = try documents.map({ document in
            //                       return try document.data(as: Post.self)
            //                    })
            
            // 방법 3 compactMap(nil이면 pass함)
            self.posts = try documents.compactMap({ document in
                return try document.data(as: Post.self)
            })
        } catch {
            print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
        }
    }
}
