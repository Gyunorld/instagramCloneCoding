//
//  ProfileView.swift
//  instagramClone
//
//  Created by 김민규 on 10/4/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel = ProfileViewModel()
    
    let columns : [GridItem] = [
//        GridItem(.fixed(100)),    // 값이 고정되어 화면 크기에 상관없이 사진이 정해진 크기로 출력됨
        GridItem(.flexible(), spacing: 2),  // 가로 간격 조정
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),  // 화면 크기에 따라 사진의 크기가 변경됨
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("\(viewModel.username)")
//                    Text("username")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    HStack {
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else if let imageUrl = viewModel.user?.profileImageUrl {
                            let url = URL(string: imageUrl)
                            KFImage(url)    // 자동으로 cache구현
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundStyle(Color(.systemGray3))
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                        VStack {
                            Text("124")
                                .fontWeight(.semibold)
                            Text("게시물")
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("999")
                                .fontWeight(.semibold)
                            Text("팔로워")
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("1403")
                                .fontWeight(.semibold)
                            Text("팔로잉")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    Text("\(viewModel.name)")
//                    Text("name")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text("\(viewModel.bio)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    if viewModel.user?.isCurrentUser == true {
                        NavigationLink {
                            ProfileEditingView(viewModel: viewModel)
                        } label: {
                            Text("프로필 편집")
                                .bold()
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                        }
                    } else {
                        Button {
                            print("followoing")
                        } label: {
                            Text("팔로우")
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                        }
                    }
                    Divider()
                        .padding()
                    
                    LazyVGrid(columns: columns, spacing: 2) { // 세로 간격 변경
                        ForEach(viewModel.posts) { post in
                            let url = URL(string: post.imageUrl)
                            KFImage(url)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                        }
                    }
                    .onAppear() // async가 아닌 경우
                    .task { // async인 경우
                        await viewModel.loadUserPosts()
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    Task {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
