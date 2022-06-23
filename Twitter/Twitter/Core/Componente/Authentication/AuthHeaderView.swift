//
//  AuthHeaderView.swift
//  Twitter
//
//  Created by Andrei Mareși on 17.06.2022.
//

import SwiftUI
//we will use this header in Login,Register and UploadUserInfo that's why we need to have it as a HeaderView
struct AuthHeaderView: View {
    let big_title: String
    let little_title: String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack { Spacer() } //sau Zstack
            Text(big_title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(little_title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(big_title: "Hello", little_title: "Welcome Back")
    }
}
