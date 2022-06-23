//
//  SideMenuView.swift
//  Twitter
//
//  Created by Andrei Mareși on 16.06.2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authviewModel: AuthViewModel
    var body: some View {
        
        if let user = authviewModel.currentUser {
            VStack(alignment: .leading, spacing: 32){
                    VStack(alignment: .leading) {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 48, height: 48)
                        VStack(alignment: .leading,spacing: 4){
                            Text(user.fullname)
                                .font(.headline)
                            Text("@\(user.username)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        UserStatsView()
                            .padding(.vertical)
                    }
                    .padding(.leading)
                
                //profile opt list
                ForEach(SideMenuViewModel.allCases, id: \.rawValue){
                    viewModel in
                    if viewModel == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMOptionRowView(viewModel: viewModel)
                        }
                    } else if viewModel == .logout {
                        Button {
                            authviewModel.signOut()
                        } label:{
                            SideMOptionRowView(viewModel: viewModel)
                        }  //azi am adaugat aici
                    } else if viewModel == .liste {
                        NavigationLink {
                            UploadUserInfoView()
                        } label: {
                            SideMOptionRowView(viewModel: viewModel)
                        }
                        
                    }else {
                        SideMOptionRowView(viewModel: viewModel)
                    }
                
                    
                }
                //.padding(.vertical,4)
                
                Spacer()
            }
        }
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}


