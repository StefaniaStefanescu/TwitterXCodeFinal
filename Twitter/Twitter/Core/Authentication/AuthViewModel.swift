//
//  AuthViewModel.swift
//  Twitter
//
//  Created by Andrei Mareși on 17.06.2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore
//import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthuser = false
    @Published var didUploadUserInfo = false
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    private let service = UserService()
    
    init(){
        
        self.userSession = Auth.auth().currentUser //daca am un user logat, stochez sesiunea user-ului in variabila
        
       // print("DEBUG: User session is \(self.userSession?.uid)")
        self.fetchUser()
        
    }
    func login(withEmail email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: failed to login user with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user     //nu ma lasa sa pun poza de profil 
            self.fetchUser()
            print("DEBUG: login with email \(email)")
            
        }
    }
    
    func register(withEmail email:String, password: String, fullname: String, username: String){
        
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: failed to register user with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.tempUserSession = user
            //self.userSession = user
            
            //print("DEBUG: register user succeded!")
            //print("DEBUG: user is \(self.userSession) ")
            
            //key value store
            let data = ["email": email, "username": username.lowercased(), "fullname" : fullname, "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthuser = true
                }
            
        }
    }
    ///
    
   func register_info(withUid description: String, location: String, link: String){
        guard let uid =  tempUserSession?.uid else { return }
        let data = ["description": description, "location": location, "link": link]
        Firestore.firestore().collection("users_info")
            .document(uid)
            .setData(data) { _ in
                print("DEBUG: informatii stocate cu succes")
                self.didUploadUserInfo = true
            }
        
       
    }
    
    
    
   // func UploadInfo(withUid userID: String, description: String, location: String, link: String){
   //     let data = ["userID": userID, "description": description, "location" : location, "link": link]
  //     guard let uid = self.userSession?.uid else { return }
   //     Firestore.firestore().collection("users_info")
    //        .document(uid)
   //         .setData(data) { _ in
  //              self.didUploadUserInfo = true
   // }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfilePicture(_ image: UIImage){
        guard let uid =  tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                    
                }
        }
    }
    
    func fetchUser(){
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}
