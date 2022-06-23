//
//  TwitterApp.swift
//  Twitter
//
//  Created by Andrei Mareși on 15.06.2022.
//

import SwiftUI
import Firebase

@main
struct TwitterApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //MainTabView()
            NavigationView{
                ContentView()
                //ProfilePicSelectorView()  //pt testare image picker
                //LoginView()
            }
            .environmentObject(viewModel)
        }
    }
}
