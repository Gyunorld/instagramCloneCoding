//
//  NewPostView.swift
//  instagramClone
//
//  Created by 김민규 on 9/27/24.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @State var caption = ""
    @Binding var tabIndex : Int
    @State var selectedItem: PhotosPickerItem?
    @State var postImage: Image?
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.postImage = Image(uiImage: uiImage)
        
    }
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("뒤로가기")
                    tabIndex = 0
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
                Spacer()
                Text("새 게시물")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)
            
            PhotosPicker(selection: $selectedItem){
                if let image = self.postImage { // self.postImage가 nil이 아니면, photosPicker로 사진을 장착한 후
                    image
                        .resizable()
//                        .aspectRatio(1, contentMode: .fit)  // 가로세로 비율
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 400) // 사진을 알맞게 넣는 방법
                        .clipped()
                } else { // 사진 선택 전 아이콘 출력
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
//                        .aspectRatio(1, contentMode: .fit)  // 가로세로 비율
//                        .frame(width: 200, height: 200) // 사진을 알맞게 넣는 방법
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                        .tint(.black)
                }
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    await convertImage(item: newValue)
                }
            }
            
            TextField("문구를 작성하거나 설문을 추가하세요...", text: $caption) // 바인딩해서 넣어줘야함 -> 빈 문자열이기 때문에
                .padding()
            
            Spacer()

            Button{
                print("사진 공유")
            } label: {
                Text("공유")
                    .frame(width: 363, height: 42)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
            

        }
    }
}

#Preview {
    NewPostView(tabIndex: .constant(2))
}
