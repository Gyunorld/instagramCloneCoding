//
//  ContentView.swift
//  Binding
//
//  Created by 김민규 on 9/27/24.
//

import SwiftUI

struct MyView: View {
    @Binding var text : String // 하위 뷰에서 수정하기 위해서는 무조건 Binding
    
    var body: some View {
        Text("My View")
        Text(text)
        Button("하트추가"){
            text = text + "❤️"
        }
    }
}

struct ContentView: View {
    @State var text: String = ""    // @State -> 변경되면 모든 곳에서 수정됨
    
    var body: some View {
        VStack {
            Text(text)  // 읽기만 가능
                .border(.blue,width: 1)
            TextField("글자를 입력해주세요", text: $text) // 바인딩시에 하위 뷰에서 수정가능함 -> 그래서 수정 가능
            Button("하트추가"){
                text = text + "❤️"
            }
            Divider()
            MyView(text: $text)
        }
    }
}

#Preview {
    ContentView()
}
