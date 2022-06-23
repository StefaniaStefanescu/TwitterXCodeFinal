//
//  ExploreView.swift
//  Twitter
//
//  Created by Andrei Mareși on 15.06.2022.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel = ExploreViewModel()
    //@State private var searchText = ""
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchableUsers) { user in
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            UserRowView(user: user)
                        }
                    }
                }
            }
            //.navigationBarTitle("Explore")
            //.navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarTitle("Explore")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
