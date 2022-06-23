//
//  TweetRowViewModel.swift
//  Twitter
//
//  Created by Andrei Mareși on 20.06.2022.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    
    
    @Published var tweet: Tweet
    private let service = TweetService()
    init(tweet: Tweet){
        self.tweet = tweet
        checkIfUserLikedTweet()
        checkIfUserSavedTweet()
        CheckIfUserRetweeted()
        
    }
    func likeTweet() {
        service.likeTweet(tweet) {
            self.tweet.didlike = true
        }
    }
    
    func unlikeTweet(){
        service.unlikeTweet(tweet) {
            self.tweet.didlike = false
        }
    }
    func checkIfUserLikedTweet(){
        service.checkIfUserLikedTweet(tweet) { didlike in
            if didlike {
                self.tweet.didlike = true
            }
        }
    }
    
   //saving tweet
    
    func saveTweet(){
        service.saveTweet(tweet) {
            self.tweet.didSave = true
        }
    }
    func checkIfUserSavedTweet(){
        service.checkIfUserSavedTweet(tweet) { didsave in
            if didsave {
                self.tweet.didSave = true
            }
        }
    }
    
    func unsaveTweet(){
        service.unsaveTweet(tweet) {
            self.tweet.didSave = false
        }
    }
    
    //retweet
    func retweet(){
        service.retweetTweet(tweet) {
                self.tweet.didRetweet = true
            
        }
    }
    
    func delretweet(){
        service.delretweetTweet(tweet) {
            self.tweet.didRetweet = false
        }
    }
    
    func CheckIfUserRetweeted(){
        service.CheckIfUserRetweetedTweet(tweet) { didRetweet in
            if didRetweet {
                self.tweet.didRetweet = true
            }
        }
    }
}
