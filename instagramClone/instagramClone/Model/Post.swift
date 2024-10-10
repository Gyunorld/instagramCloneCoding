//
//  Post.swift
//  instagramClone
//
//  Created by 김민규 on 9/30/24.
//

import Foundation

//struct Post: Encodable, Decodable {
struct Post: Codable, Identifiable {
    let id: String
    let userId: String
    let caption: String
    var like: Int
    let imageUrl: String
    let date: Date
    var isLike: Bool?
    
    var user: User?
}

extension Post {
    static var DUMMY_POST: Post = Post(id: UUID().uuidString, userId: UUID().uuidString, caption: "test caption", like: 123, imageUrl:
                                        "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-b8f5a.appspot.com/o/images%2F85EF4C0A-7EAC-4243-9AA5-53F8FF625BD6?alt=media&token=4454253d-0ef4-41e9-9ec0-7e09b6bc6697", date: Date())
}
