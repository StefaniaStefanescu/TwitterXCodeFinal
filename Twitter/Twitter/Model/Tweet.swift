//
//  Tweet.swift
//  Twitter
//
//  Created by Andrei Mareși on 20.06.2022.
//


import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    
    var user: User?
    //user related values , same for replies
    
    var didlike: Bool? = false
    var didSave: Bool? = false
    var didRetweet: Bool? = false
}
