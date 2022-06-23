//
//  UserService.swift
//  Twitter
//
//  Created by Andrei Mareși on 19.06.2022.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
       // print("DEBUG: Fetching user info....")
        //iau datele ca un bloc din firebase storage apoi le split-uiesc pentru afisare
        //getting info from the API
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot , _ in
            guard let snapshot = snapshot else { return }
            //print("DEBUG: user data is \(data)")
            guard let user = try? snapshot.data(as: User.self) else { return }
           // print("DEBUG: username is \(user.username)")
            //print("DEBUG: email is \(user.email)")
            completion(user)
            
        }
        
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void){
        //var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                //alows us to shorten up for loops etc, take data and map it for transforming it into user objects.
                let users = documents.compactMap({ try? $0.data(as: User.self) })
            
               // documents.forEach { document in
               //     guard let user = try? document.data(as: User.self) else { return }
               //     users.append(user)
               // }
                
                completion(users)
            }
    }
    
    
    func UpdateUserInfo(withUid uid: String, completion: @escaping() -> Void){
        
    }
    
}

