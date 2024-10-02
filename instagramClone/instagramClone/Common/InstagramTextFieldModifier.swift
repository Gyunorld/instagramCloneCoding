//
//  InstagramTextFieldModifier.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import SwiftUI

struct InstagramTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)    // 무조건 첫 글자 대문자 방지
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            }
            .padding(.horizontal)
    }
}


