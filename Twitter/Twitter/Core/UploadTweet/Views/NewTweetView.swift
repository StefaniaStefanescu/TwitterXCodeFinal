//
//  NewTweetView.swift
//  Twitter
//
//  Created by Andrei Mareși on 16.06.2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    //recunoaste stadiul de prezentare al aplicatiei
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadTweetViewModel()
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                Spacer()
                
                Button {
                    //print("Tweet")
                    viewModel.uploadTweet(withCaption: caption)
                    
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }

            }
            .padding()
            HStack(alignment: .top){
                if let user = authViewModel.currentUser{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                TestArea("La ce te gandesti?", text: $caption)
                
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadTweet) { succes in
            if succes {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
