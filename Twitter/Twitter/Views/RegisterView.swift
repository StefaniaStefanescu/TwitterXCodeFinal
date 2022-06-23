//
//  RegisterView.swift
//  Twitter
//
//  Created by Andrei Mareși on 16.06.2022.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            
            NavigationLink(destination: ProfilePicSelectorView(), isActive: $viewModel.didAuthuser , label: { })
           AuthHeaderView(big_title: "Let's get started!", little_title: "Create your account.")
            
            VStack(spacing: 40) {
                CustomImputField(image: "envelope", placeholderText: "Email", text: $email)
                CustomImputField(image: "person", placeholderText: "Username", text: $username)
                CustomImputField(image: "person", placeholderText: "Full name", text: $fullname)
                CustomImputField(image: "lock", placeholderText: "Password", isSecureField: true, text: $password)
            }
            .padding(32)
            
            Button{
                viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            }label:{
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            
           Spacer()
           Button {
               presentationMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Text("You already have an account?")
                        .font(.footnote)
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom,32)
            
        }
        .ignoresSafeArea()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
