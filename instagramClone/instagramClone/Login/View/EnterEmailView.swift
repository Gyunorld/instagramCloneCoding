//
//  EnterEmailView.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import SwiftUI

struct EnterEmailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignupViewModel.self) var signupViewModel  // 읽기만 할 때는 여기까지만 작성해도 됨
    
    var body: some View {
        @Bindable var signupViewModel = signupViewModel // 입력을 받을 시에는 이것까지 작성해야함
        SignupBackgroundView {
            VStack {
                Text("이메일 주소 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("이메일 주소",text: $signupViewModel.email)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {

                    EnterPasswordView()
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
    EnterEmailView()
}
