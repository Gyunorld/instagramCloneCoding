//
//  User.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import Foundation
import FirebaseAuth

struct User: Codable, Identifiable {
    let id: String
    let email: String
    var username: String
    var name: String
    var bio: String?
    var profileImageUrl: String?
    var isFollowing: Bool?
    
    var userCountInfo: UserCountInfo?
    
    var isCurrentUser: Bool {
        guard let currentUserId = AuthManager.shared.currentUser?.id else { return false }
//        if id == currentUserId {
//            return true
//        } else {
//            return false
//        }
        
        return id == currentUserId
    }
}

extension User {
    static var DUMMY_USER = User(
        id: UUID().uuidString,
        email: "dummy@email.com",
        username: "dummy",
        name: "Dummy"
    )
}
