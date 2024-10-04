//
//  ProfileEditingView.swift
//  instagramClone
//
//  Created by 김민규 on 10/4/24.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct ProfileEditingView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: ProfileViewModel // class로 받는 경우는 Bindable
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.selectedItem) {
                VStack{
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
                        
//                        AsyncImage(url: url) { image in
//                            image
//                                .resizable()
//                                .frame(width: 75, height: 75)
//                                .clipShape(Circle())
//                                .padding(.bottom, 10)
//                        } placeholder: {
//                            ProgressView()
//                        }     // 사진 계속해서 새롭게 불러옴
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundStyle(Color(.systemGray3))
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                    }
                    Text("사진 또는 아바타 수정")
                        .foregroundStyle(.blue)
                }
            }
            .onChange(of: viewModel.selectedItem) { oldValue, newValue in
                Task {
                    await viewModel.convertImage(item: newValue)
                }
            }
            
            VStack(alignment: .leading, spacing: 5){
                Text("이름")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                TextField("이름", text: $viewModel.name)
                    .font(.title2)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 5){
                Text("사용자 이름")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                TextField("사용자 이름", text: $viewModel.username)
                    .font(.title2)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 5){
                Text("소개")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                TextField("소개", text: $viewModel.bio)
                    .font(.title2)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
        }
        .navigationTitle("프로필 편집")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    Task {
                        await viewModel.updateUser()
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
    ProfileEditingView(viewModel: ProfileViewModel())
}
