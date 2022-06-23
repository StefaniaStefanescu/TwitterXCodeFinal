//
//  ProfileViewModel.swift
//  Twitter
//
//  Created by Andrei Mareși on 20.06.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    @Published var savedTweets = [Tweet]()
    @Published var retweetedTweets = [Tweet]()
    private let service = TweetService()
    private let userService = UserService()
    let user: User
    var usersearched = ""
    
    init(user: User){
        //self.usersearched = user
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
        self.fetchSavedTweets()
        self.FetchRetweetedTweets()
    }
    
    var actionButtonTitle: String {
        //
        var uid = user.id
        //guard let uid = user.id else { return }
        if !user.isCurrentUser {
           
           usersearched = uid ?? ""
            print("DEBUG: new UID: \(usersearched)")
        }
        //
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet]{
        switch filter {
        case .tweets:
            return tweets
        case .replies:
            return retweetedTweets   //de completat
        case .media:
            return savedTweets
        case .likes:
            return likedTweets
        }
    }
   
    func fetchUserTweets(){
        guard let uid = user.id else { return }
        service.fetchTweets(forUid: uid) { tweets in
            self.tweets = tweets
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    
    
    func fetchLikedTweets() {
        guard let uid = user.id else { return }
        service.fetchLikedTweets(forUid: uid) { tweets in
            self.likedTweets = tweets
            
            for i in 0 ..< tweets.count{
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedTweets[i].user = user
                }
            }
            
        }
    }
    
    func fetchSavedTweets() {
        guard let uid = user.id else { return }
        service.fetchSavedTweets(forUid: uid) { tweets in
            self.savedTweets = tweets
            
            for i in 0 ..< tweets.count{
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.savedTweets[i].user = user
                }
            }
            
        }
    }
    
    func FetchRetweetedTweets(){
        guard let uid = user.id else { return }
        service.fetchSavedTweets(forUid: uid) { tweets in
            self.retweetedTweets = tweets
            
            for i in 0 ..< tweets.count{
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.retweetedTweets[i].user = user
                }
            }
            
        }
    }
}
