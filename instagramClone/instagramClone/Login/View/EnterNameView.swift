//
//  EnterNameView.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import SwiftUI

struct EnterNameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        @Bindable var signupViewModel = signupViewModel
        SignupBackgroundView {
            VStack {
                Text("이름 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                TextField("성명",text: $signupViewModel.name)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    EnterUsernameView()
                } label: {
                    Text("다음")
                        .foregroundStyle(.white)
                        .frame(width: 363, height: 42)  // 사이즈 먼저 정하고 색상 추가해야함
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
                
            }
        }
    }
}

#Preview {
    EnterNameView()
}
