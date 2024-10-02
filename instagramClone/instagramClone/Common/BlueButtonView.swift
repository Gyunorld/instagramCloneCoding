//
//  BlueButtonView.swift
//  instagramClone
//
//  Created by 김민규 on 10/2/24.
//

import SwiftUI

struct BlueButtonView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let label: Content
    let action: () -> Void
    
    init(action: @escaping () -> Void, @ViewBuilder label: () -> Content) {
        self.label = label()
        self.action = action
    }
    
    var body: some View {
        Button{
            action()
        } label: {
            label
                .foregroundStyle(.white)
                .frame(width: 363, height: 42)  // 사이즈 먼저 정하고 색상 추가해야함
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        
    }
}

