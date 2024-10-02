//
//  LoginView.swift
//  instagramClone
//
//  Created by 김민규 on 10/1/24.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack{
                GradientBackgroundView()
                
                VStack{
                    Spacer()
                    Image("instagramLogo")
                        .resizable()
                        .frame(width: 57, height: 57)
                    Spacer()
                    
                    VStack(spacing: 20){
                        TextField("이메일주소",text: $viewModel.email)
                            .modifier(InstagramTextFieldModifier())
                        
                        SecureField("비밀번호", text: $viewModel.password)
                            .modifier(InstagramTextFieldModifier())
                        
                        BlueButtonView {
                            Task {
                                await viewModel.signin()
                            }
                        } label: {
                            Text("로그인")
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            EnterEmailView()
                        } label: {
                            Text("새 계정 만들기")
                                .fontWeight(.bold)
                                .frame(width: 363, height: 42)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.blue, lineWidth: 1.0)
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
