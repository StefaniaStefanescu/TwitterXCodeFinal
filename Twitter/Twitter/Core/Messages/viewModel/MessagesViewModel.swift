//
//  MessagesViewModel.swift
//  Twitter
//
//  Created by Andrei Mareși on 21.06.2022.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class MessagesViewModel: ObservableObject {
    let service = FollowService()
    
    @Published var users_followed = [User]()
    init() {
        fetchUsers()
    }
    func fetchUsers() {
        service.FetchFollowing(forUid: Auth.auth().currentUser?.uid ?? "" ) { users in
            self.users_followed = users
            
            //print("DEBUG: users are: \(users)")
            
        }
    }
}
