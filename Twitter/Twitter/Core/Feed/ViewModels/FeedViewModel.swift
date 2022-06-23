//
//  FeedViewModel.swift
//  Twitter
//
//  Created by Andrei Mareși on 20.06.2022.
//

import Foundation


class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    let service = TweetService()
    let userService = UserService()
    init(){
        fetchTweets()
    }
    
    // we need to fetch all the tweets from the firebase storage in order to display them on the screen
    func fetchTweets(){
        service.fetchTweets { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count{
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.tweets[i].user = user
                }
            }
           
        }
    
   }
}
