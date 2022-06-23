//
//  SideMOptionRowView.swift
//  Twitter
//
//  Created by Andrei Mareși on 16.06.2022.
//

import SwiftUI

struct SideMOptionRowView: View {
    let viewModel: SideMenuViewModel
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: viewModel.imageName )
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(viewModel.description)
                .foregroundColor(.black)
                .font(.subheadline)
            
           

            Spacer()
            
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMOptionRowView(viewModel: .profile)
    }
}
