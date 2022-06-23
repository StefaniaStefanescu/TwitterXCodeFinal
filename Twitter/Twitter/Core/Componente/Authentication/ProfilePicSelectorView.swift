//
//  ProfilePicSelectorView.swift
//  Twitter
//
//  Created by Andrei Mareși on 17.06.2022.
//

import SwiftUI

struct ProfilePicSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack{
            AuthHeaderView(big_title: "Creating account...", little_title: "Add a profile photo")
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())
                        
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .modifier(ProfileImageModifier())
                        
                }
                    
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
                imagePicker(selectedImage: $selectedImage)
            }
            .padding(.top,44)
            
            if let selectedImage = selectedImage {
                Button{
                    viewModel.uploadProfilePicture(selectedImage)
                }label:{
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }
        
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else {
            return
        }
        profileImage = Image(uiImage: selectedImage)

    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.systemBlue))
            .scaledToFit()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
    }
}
struct ProfilePicSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicSelectorView()
    }
}
