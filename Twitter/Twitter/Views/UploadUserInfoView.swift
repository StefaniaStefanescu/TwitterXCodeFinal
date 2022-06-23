//
//  UploadUserInfoView.swift
//  Twitter
//
//  Created by Andrei Mareși on 21.06.2022.
//

import SwiftUI

struct UploadUserInfoView: View {
    //@State private var userID = ""
    @State private var description = ""
    @State private var location = ""
    @State private var link = ""
   // @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            //NavigationLink(destination: ProfilePicSelectorView(), isActive: $viewModel.didUploadUserInfo , label: { })
           AuthHeaderView(big_title: "You've made some changes?!", little_title: "Let's complete some information.")
            
            VStack(spacing: 40) {
                CustomImputField(image: "rectangle.and.pencil.and.ellipsis", placeholderText: "description", text: $description)
                CustomImputField(image: "location", placeholderText: "location", text: $location)
                CustomImputField(image: "link", placeholderText: "link", text: $link)
              
            }
            .padding(32)
            Button{
                viewModel.register_info(withUid: description, location: location, link: link)
            }label:{
                Text("Ready")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
        }
        .ignoresSafeArea()
    }
}

struct UploadUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UploadUserInfoView()
    }
}
