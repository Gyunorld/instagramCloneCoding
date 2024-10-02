//
//  AuthManager.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import Foundation
import FirebaseAuth
import Firebase

@Observable
class AuthManager {
    static let shared = AuthManager()
    
    var currentAuthUser: FirebaseAuth.User?
    
    var currentUser: User?
    
    // 회원가입 후 유지
    init() {
        currentAuthUser = Auth.auth().currentUser
        Task {
            await loadUserData()
        }
    }
    
    func createUser(email: String, password: String, name: String, username: String) async{
        print("email:",email)
        print("password:",password)
        print("name:",name)
        print("username:",username)
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else {return}
            await uploadUserData(userId: userId, email: email, username: username, name: name)
        } catch {
            print("DEBUG:",error.localizedDescription)
        }
    }
    
    func uploadUserData(userId: String, email: String, username: String, name: String) async{
        let user = User(id: userId, email: email, username: username, name: name)
        self.currentUser = user
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("DEBUG:", error.localizedDescription)
        }
        
    }
    
    func signin(email: String, password: String) async {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentAuthUser = result.user
            await loadUserData()
        } catch {
            print("DEBUG:", error.localizedDescription)
        }
    }
    
    func loadUserData() async {
        guard let userId = self.currentAuthUser?.uid else { return }
        do{
            self.currentUser = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            print("currentUser:",currentUser)
        } catch {
            print("DEBUG:", error.localizedDescription)
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            currentAuthUser = nil
        } catch {
            print("DEBUG:", error.localizedDescription)
        }
    }
}
