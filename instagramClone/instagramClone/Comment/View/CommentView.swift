//
//  CommentView.swift
//  instagramClone
//
//  Created by 김민규 on 10/10/24.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    @State var commentText = ""
    @State var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            Text("댓글")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 15)
                .padding(.top, 30)
            Divider()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.comments) { comment in
                        CommentCellView(comment: comment)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                }
            }
            Divider()
            HStack {
                if let imageUrl = AuthManager.shared.currentUser?.profileImageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }
                TextField("댓글추가", text: $commentText, axis: .vertical)
                Button {
                    Task {
                        await viewModel.uploadComment(commentText: commentText)
                        commentText = ""
                    }
                } label: {
                    Text("보내기")
                }
                .tint(.black)
            }
            .padding()
        }
    }
}

#Preview {
    CommentView(post: Post.DUMMY_POST)
}
