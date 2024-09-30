//
//  NewPostViewModel.swift
//  instagramClone
//
//  Created by 김민규 on 9/30/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import Firebase
import FirebaseFirestoreCombineSwift

@Observable
class NewPostViewModel {
    var caption = ""
    var selectedItem: PhotosPickerItem?
    var postImage: Image?
    var uiImage: UIImage?
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.postImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
        
    }
    
    func uploadPost() async {
        
        guard let uiImage else { return }
        guard let imageUrl = await uploadImage(uiImage: uiImage) else { return }
        
        // collection: 엑셀의 시트 , document : 열
        let postReference = Firestore.firestore().collection("posts").document()
        let post = Post(id: postReference.documentID, caption: caption, like: 0, imageUrl: imageUrl, date: Date())
        
        do {
            let encodedData = try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        } catch {
            print("DEBUG: Failed To upload post with error \(error.localizedDescription)")
        }
    }
    
    func uploadImage(uiImage: UIImage) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString
        print("fileName:",fileName)
        let reference = Storage.storage().reference(withPath: "/images/\(fileName)")
        
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
    
    func clearData() {
        caption = ""
        selectedItem = nil
        postImage = nil
        uiImage = nil
    }
}
