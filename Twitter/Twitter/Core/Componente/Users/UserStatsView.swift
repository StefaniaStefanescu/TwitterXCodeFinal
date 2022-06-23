//
//  UserStatsView.swift
//  Twitter
//
//  Created by Andrei Mareși on 16.06.2022.
//

import SwiftUI


//aici ar trebui sa iau infortamii din UserInfo
struct UserStatsView: View {
    var body: some View {
        HStack(spacing: 24) {
            HStack(spacing:4){
                Text("1000").font(.subheadline).bold()
                Text("Following").font(.caption).foregroundColor(.gray)
                
            }
            //Spacer()
            HStack(spacing: 4){
                Text("1M").font(.subheadline).bold()
                Text("Followers").font(.caption).foregroundColor(.gray)
            }
            
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
