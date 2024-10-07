//
//  FeedCellView.swift
//  instagramClone
//
//  Created by 김민규 on 10/7/24.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {
    @State var viewModel: FeedCellViewModel
    
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        let _ = print("image loading completed")
        VStack {
//            Image("image_dragon2")
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HStack {
//                        Image("image_lion4")
                        KFImage(URL(string: viewModel.post.user?.profileImageUrl ?? ""))
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color(red: 191/255, green: 11/255, blue: 180/255), lineWidth: 2)
                            }
//                        Text("Tiger")
                        Text("\(viewModel.post.user?.username ?? "")")
                            .foregroundStyle(.white)
                            .bold()
                        Spacer()
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                            .imageScale(.large)
                    }
                    .padding(5)
                }
            
            HStack {
                Image(systemName: "heart")
                Image(systemName: "bubble.right")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
            }
            .imageScale(.large)
            .padding(.horizontal)
            Text("좋아요 \(viewModel.post.like)개")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("\(viewModel.post.user?.username ?? "")" + " " + viewModel.post.caption)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("댓글 25개 더보기")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("\(viewModel.post.date.relativeTimeString())")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        .padding(.bottom)
    }
}

//#Preview {
//    FeedCellView(post: Post(id: <#T##String#>, userId: <#T##String#>, caption: <#T##String#>, like: <#T##Int#>, imageUrl: <#T##String#>, date: <#T##Date#>))
//}
