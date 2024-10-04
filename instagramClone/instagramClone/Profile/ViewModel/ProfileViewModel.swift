//
//  ProfileViewModel.swift
//  instagramClone
//
//  Created by 김민규 on 10/4/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

@Observable
class ProfileViewModel {
    var user: User?
    
    var name: String
    var username: String
    var bio: String
    
    var posts: [Post] = []
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    init() {
//        self.user = AuthManager.shared.currentUser
        let tempUser = AuthManager.shared.currentUser
        self.user = tempUser
        
        self.name = tempUser?.name ?? ""
        self.username = tempUser?.username ?? ""
        self.bio = tempUser?.bio ?? ""
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
    }
    
    func updateUser() async {
        do {
            try await updateUserRemote()
            updateUserLocal()
        } catch {
            print("DEBUG: Failed to update user data with error \(error.localizedDescription)")
        }
    }
    
    func updateUserLocal() {
        if name != "", name != user?.name {
            user?.name = name
        }
        if username.isEmpty == false, username != user?.username {
            user?.username = username
        }
        if !bio.isEmpty, bio != user?.bio {
            user?.bio = bio
        }
    }
    
    func updateUserRemote() async throws {
        var editedData: [String: Any] = [:]
        
        if name != "", name != user?.name {
            editedData["name"] = name
        }
        if username.isEmpty == false, username != user?.username {
            editedData["username"] = username
        }
        if !bio.isEmpty, bio != user?.bio {
            editedData["bio"] = bio
        }
        if let uiImage = self.uiImage {
            let imageUrl = await uploadImage(uiImage: uiImage)
            editedData["profileImageUrl"] = imageUrl
        }
        
        if !editedData.isEmpty, let userId = user?.id {
            try await Firestore.firestore().collection("users").document(userId).updateData(editedData)
        }
        
        
    }
    
    func uploadImage(uiImage: UIImage) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString
        print("fileName:",fileName)
        let reference = Storage.storage().reference(withPath: "/profile/\(fileName)")
        
        do{
           let metaData = try await reference.putDataAsync(imageData)
            print("metaData:", metaData)
            let url = try await reference.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with erro \(error.localizedDescription)")
            return nil
        }

    }
 
    func loadUserPosts() async {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true)
                .whereField("userId", isEqualTo: user?.id ?? "").getDocuments().documents
            
            var posts: [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self)
                posts.append(post)
            }
            self.posts = posts
        } catch {
            print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
        }
    }
}
