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
    @State var isCommentShowing = false
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        VStack {
//            Image("image_dragon2")
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HStack {
                        NavigationLink {
                            if let user = viewModel.post.user {
                                ProfileView(viewModel: ProfileViewModel(user: user))
                            }
                        } label: {
                            KFImage(URL(string: viewModel.post.user?.profileImageUrl ?? ""))
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color(red: 191/255, green: 11/255, blue: 180/255), lineWidth: 2)
                                }

                            Text("\(viewModel.post.user?.username ?? "")")
                                .foregroundStyle(.white)
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                            .imageScale(.large)
                    }
                    .padding(5)
                }
            
            HStack {
                let isLike = viewModel.post.isLike ?? false
                Button {
                    Task {
                        isLike ? await viewModel.unlike() : await viewModel.like()
                    }
                } label: {
                    Image(systemName: isLike ? "heart.fill" : "heart")
                        .foregroundStyle(isLike ? .red : .primary)
                }
                Button {
                    isCommentShowing = true
                } label: {
                    Image(systemName: "bubble.right")
                }
 
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
            Button {
                isCommentShowing = true
            } label: {
                Text("댓글 \(viewModel.commentCount)개 더보기")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
            Text("\(viewModel.post.date.relativeTimeString())")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        .padding(.bottom)
        .sheet(isPresented: $isCommentShowing) {
            CommentView(post:viewModel.post)
                .presentationDragIndicator(.visible)
        }
        .onChange(of: isCommentShowing) { oldValue, newValue in
            if newValue == false {
                Task {
                    await viewModel.loadCommentCount()
                }
            }
        }
    }
}

#Preview {
    FeedCellView(post: Post(id: "iMP2FX2V6cDGwhMAodRw", userId: "GzaQsA3lFlaPyP9TJi9poTnEgG42", caption: "Panda", like: 0, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-a5529.appspot.com/o/images%2F4826A681-3158-43E0-AFD2-7D40E9CB2A39?alt=media&token=614cee3b-2b12-462f-bab5-1836fe8620b0", date: Date()))
}
