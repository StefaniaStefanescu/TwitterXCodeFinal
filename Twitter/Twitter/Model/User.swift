//
//  User.swift
//  Twitter
//
//  Created by Andrei Mareși on 19.06.2022.
//

import FirebaseFirestoreSwift   //decodable protocol pt cod firebase
import Firebase
//user object ----->poop pentru maparea datelor luate din firestorage

//Decodable = reads the dictionary and tries to look for the exact name of the keys in the data dictionary.
//that's why i keept the name from the firestorage 
struct User: Identifiable,Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}


