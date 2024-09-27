//
//  ImageFitAndFillView.swift
//  instagramClone
//
//  Created by 김민규 on 9/27/24.
//

import SwiftUI

struct ImageFitAndFillView: View {
    var body: some View {
        VStack {
//            Image(systemName: "trash.square.fill")
//                .resizable()
//            Rectangle()
//                .frame(width: 200, height: 100)
            Image(systemName: "trash.square.fill")
                .resizable()
                .frame(width: 200, height: 100)
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 100)
                .border(.pink, width: 2)
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 100)
                .border(.blue, width: 1)
                .clipped()
            Image(systemName: "trash.square.fill")
                .resizable()
//                .aspectRatio(contentMode: .fit)
                .aspectRatio(3/1, contentMode: .fit)
                .frame(width: 200, height: 100)
                .border(.pink, width: 2)
            Image(systemName: "trash.square.fill")
                .resizable()
//                .aspectRatio(contentMode: .fill)
                .aspectRatio(3, contentMode: .fill)
                .frame(width: 200, height: 100)
                .border(.blue, width: 1)
                .clipped()
        }
    }
}

#Preview {
    ImageFitAndFillView()
}
