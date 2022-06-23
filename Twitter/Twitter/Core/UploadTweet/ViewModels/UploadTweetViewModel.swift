//
//  UploadTweetViewModel.swift
//  Twitter
//
//  Created by Andrei Mareși on 20.06.2022.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var didUploadTweet = false
    let service = TweetService()
    func uploadTweet(withCaption caption: String) {
        service.uploadTweet(caption: caption) { succes in
            if succes{
                //iesire din ecran
                self.didUploadTweet = true
            } else {
                //afisare mesaj de eroare
                
            }
        }
    }
}
