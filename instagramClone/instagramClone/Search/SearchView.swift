  //
//  SearchView.swift
//  instagramClone
//
//  Created by 김민규 on 10/10/24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    @State var searchText: String = ""
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        
        //        List {
        //            ForEach(viewModel.users) { user in
        //                Text(user.username)
        //            }
        //        }
        
        NavigationStack {
            List(filteredUsers) { user in
                NavigationLink {
                    ProfileView(viewModel: ProfileViewModel(user: user))
                } label: {
                    HStack{
                        if let imageUrl = user.profileImageUrl {
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 53, height: 53)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 53, height: 53)
                                .opacity(0.5)
                        }
                        VStack(alignment: .leading) {
                            Text(user.username)
                            Text(user.bio ?? "")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "검색")
        }
    }
}

#Preview {
    SearchView()
}
