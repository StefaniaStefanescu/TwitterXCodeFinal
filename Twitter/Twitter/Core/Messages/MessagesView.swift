//
//  MessagesView.swift
//  Twitter
//
//  Created by Andrei Mareși on 15.06.2022.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var viewModel = MessagesViewModel()
    
    var body: some View {
        //Text("Here will be all the persons you are following")
        VStack {
            ScrollView {
                ForEach(viewModel.users_followed) { user in
                        UserRowView(user: user)
                }
            }
            //.navigationTitle("Explore")
            //.navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarTitle("Following")
        .navigationBarTitleDisplayMode(.inline)
    }
    
   
    
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
