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
}
