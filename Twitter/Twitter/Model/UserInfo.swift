//
//  UserInfo.swift
//  Twitter
//
//  Created by Andrei Mareși on 21.06.2022.
//
import FirebaseFirestoreSwift   //decodable protocol pt cod firebase
import Firebase

struct UserInfo: Identifiable,Decodable {
    @DocumentID var id: String?
    //let userID: String
    let description: String
    let location: String
    let link: String
   // var following: Int
}
