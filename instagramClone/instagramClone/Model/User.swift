//
//  User.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    var username: String
    var name: String
    var bio: String?
    var profileImageUrl: String?
}
