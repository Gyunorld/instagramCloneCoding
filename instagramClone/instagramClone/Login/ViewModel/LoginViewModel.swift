//
//  LoginViewMode.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import Foundation

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    
    func signin() async {
        await AuthManager.shared.signin(email: email, password: password)
    }
}
