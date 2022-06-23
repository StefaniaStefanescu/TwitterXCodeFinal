//
//  LoginView.swift
//  Twitter
//
//  Created by Andrei Mareși on 16.06.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        //parent cont
        VStack{
            //header
            
            AuthHeaderView(big_title: "Hello!", little_title: "Welcome back.")
            
            //text fields
            VStack(spacing: 40) {
                CustomImputField(image: "envelope", placeholderText: "Email", text: $email)
            
                CustomImputField(image: "lock", placeholderText: "Password", isSecureField: true, text: $password)
            }
            .padding(.horizontal,32)
            .padding(.top,44)
            
            HStack{
                Spacer()
                NavigationLink {
                    Text("Reset password...")
                } label:{
                    Text("Forgot password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing,24)
                    
                }
            }
            Button{
                viewModel.login(withEmail: email, password: password)
            }label:{
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            
            
            Spacer()
            NavigationLink{
                RegisterView()
                    .navigationBarHidden(true)
                
            } label: {
                HStack{
                    Text("You don't have an account yet?")
                        .font(.footnote)
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom,32)
            .foregroundColor(Color(.systemBlue))
            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



//2h13
