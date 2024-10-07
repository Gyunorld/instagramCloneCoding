//
//  FeedView.swift
//  instagramClone
//
//  Created by 김민규 on 10/7/24.
//

import SwiftUI

struct FeedView: View {
    @State var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("instagramLogo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                    Spacer()
                    Image(systemName: "heart")
                        .imageScale(.large)
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                .padding(.horizontal)
                
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        FeedCellView(post: post)
                    }
                }
                .listStyle(.plain)
                
//                FeedCellView()
//                FeedCellView()
//                FeedCellView()
//                FeedCellView()
                
                Spacer()
            }
        }
        .refreshable {  // 댕겨서 새로고침
            await viewModel.loadAllPosts()
        }
        .task { // 비동기로 새로고침
            await viewModel.loadAllPosts()
        }
    }
}

#Preview {
    FeedView()
}
