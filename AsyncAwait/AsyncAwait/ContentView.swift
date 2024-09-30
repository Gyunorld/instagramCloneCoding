//
//  ContentView.swift
//  AsyncAwait
//
//  Created by 김민규 on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let imageUrlString = "https://i.namu.wiki/i/9ti2PVCD4THDQKF2kjA1wgk125shONW2O8pPcrRw0RLcVX8cUW4Zt2gwLnE9em6LofspAAYdg4DLHRK2Nl0tXBZycvRanSH2NDfGJc7uFWG0LuvRBLLTAK2Tzue79EIgIkhP_Rd3_UcDSXDImJFoTQ.webp"
        VStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .frame(width: 200, height: 200)
            ScrollView {
                ForEach(0..<10) { _ in
//                    AsyncImage(url: URL(string: imageUrlString)) // 다른 thread에 넘기는 역할
                    
                    let data = try! Data(contentsOf: URL(string: imageUrlString)!)
                    Image(uiImage: UIImage(data: data)!)    // 경고문 다른 async로 넘기는 것과 유사함
                    
                    // thread => 일꾼
                    // thread1 -> 화면 그리기 (최우선 순위), 너무 오래걸리는 일은 1번이 아닌 thread에서 작동
                    // 어떤 함수가 오래 걸리는지
    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
