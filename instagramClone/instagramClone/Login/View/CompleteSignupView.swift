//
//  CompleteSignupView.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import SwiftUI

struct CompleteSignupView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        @Bindable var signupViewModel = signupViewModel
        SignupBackgroundView {
            VStack {
                Image("instagramLogo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 172, height: 172)
                    .foregroundStyle(Color.gray)
                    .overlay {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .opacity(0.5)
                            .frame(width: 185 , height: 185)
                    }
                
                Text("\(signupViewModel.username)님, Instagram에 오신 것을 환영합니다.")
                    .font(.title)
                    .padding(.top, 30)
                    .padding(.horizontal)
                Spacer()
                
                BlueButtonView{
                    Task{
                        await signupViewModel.createUser()
                    }
                } label: {
                    Text("완료")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CompleteSignupView()
}
