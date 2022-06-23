//
//  MainTabView.swift
//  Twitter
//
//  Created by Andrei Mareși on 15.06.2022.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    //@Published var TitluNavigare
    var body: some View {
        TabView(selection: $selectedIndex){
            FeedView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem{
                    Image(systemName: "house")
                    
                }.tag(0)
            ExploreView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    
                }.tag(1)
            SpacesView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem{
                    Image(systemName: "globe.europe.africa.fill")
                    
                }.tag(2)
            NotificationsView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem{
                    Image(systemName: "bell")
                    
                }.tag(3)
            MessagesView()
                .onTapGesture {
                    self.selectedIndex = 4
                }
                .tabItem{
                    Image(systemName: "person.fill.checkmark")
                        .foregroundColor(.gray)
                    
                }.tag(4)
           
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
