//
//  FollowService.swift
//  Twitter
//
//  Created by Andrei Mareși on 21.06.2022.
//

import Firebase
import FirebaseStorage
import FirebaseFirestore

struct FollowService {
    func FetchFollowing(forUid uid: String, completion: @escaping([User]) -> Void){
        var following = [User]()
        Firestore.firestore().collection("users").document(uid)
            .collection("user-follows")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let userID = doc.documentID
                    
                    Firestore.firestore().collection("users")
                        .document(userID)
                        .getDocument { snapshot, _ in
                            guard let user = try? snapshot?.data(as: User.self) else { return }
                            following.append(user)
                            completion(following)
                        }
                }
            }
       }
}
