//
//  ContentView.swift
//  MVVMTutorial
//
//  Created by 김민규 on 9/30/24.
//

import SwiftUI

struct NumberModel {
    var number: Int
}

@Observable
class ContentViewModel {
    var model = NumberModel(number: 0)
    func plusLogic() {
        if model.number % 2 == 0 { //2로 나누어서 나머지가 0이면 = 짝수이면
            model.number += 1
        } else { //홀수이면
            model.number *= 2
        }
    }
}

struct ContentView: View {
//    @State var number = 0
    @State var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.model.number)")
            Button(action: {
                viewModel.plusLogic()
            }, label: {
                Text("증가")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
