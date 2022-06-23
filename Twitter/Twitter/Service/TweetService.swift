//
//  TweetService.swift
//  Twitter
//
//  Created by Andrei Mareși on 20.06.2022.
//

import Firebase
import FirebaseStorage
import FirebaseFirestore

struct TweetService{
    
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid":uid, "caption": caption, "likes": 0, "timestamp": Timestamp(date: Date())] as [String: Any]
        
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: failed to upload tweet with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
        
        
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void){
        Firestore.firestore().collection("tweets").order(by: "timestamp", descending: true).getDocuments { snapshot , error in
            guard let documents = snapshot?.documents else { return }
            
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
            completion(tweets)
            //documents.forEach { doc in
                //print(doc.data())
                
            //}
        }
    }
    
    func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void){
        Firestore.firestore().collection("tweets").whereField("uid", isEqualTo: uid).getDocuments { snapshot , error in
            guard let documents = snapshot?.documents else { return }
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
            completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() } ))
            //documents.forEach { doc in
                //print(doc.data())
                
            //}
        }
    }
    
    func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        //print("DEBUG: Like tweet here:")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes + 1]) { _ in
            userLikesRef.document(tweetId).setData([:]) { _ in
                completion()
            }
        }
        
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes - 1]) { _ in
            userLikesRef.document(tweetId).delete{ _ in
                completion()
            }
        }
        
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {
                    return
                }

                completion(snapshot.exists)
            }
    }
    
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        Firestore.firestore().collection("users").document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            completion(tweets)
                        }
                }
            }
    }
    
    //save
    
    func saveTweet(_ tweet: Tweet, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userSavesRef = Firestore.firestore().collection("users").document(uid).collection("user-saves")
        
        //daca vreau numarul de salvari trebuie sa mai adaug un camp in baza de date  -->treaba pentru future me
            userSavesRef.document(tweetId).setData([:]) { _ in
                completion()
                
            }
        
    }
    func unsaveTweet(_ tweet: Tweet, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userSavesRef = Firestore.firestore().collection("users").document(uid).collection("user-saves")
        userSavesRef.document(tweetId).delete{ _ in
            completion()
        }
        
        
    }
    
    func checkIfUserSavedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saves")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {
                    return
                }

                completion(snapshot.exists)
            }
    }
    
    func fetchSavedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void){
        //print("DEBUG: fetching saved tweets")
        var tweets = [Tweet]()
        Firestore.firestore().collection("users").document(uid)
            .collection("user-saves")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            completion(tweets)
                        }
                }
            }
       }
    
    
    //retweets
    func retweetTweet(_ tweet: Tweet, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userSavesRef = Firestore.firestore().collection("users").document(uid).collection("user-retweets")
            userSavesRef.document(tweetId).setData([:]) { _ in
                completion()
                
            }
    }
    
    func delretweetTweet(_ tweet: Tweet, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userSavesRef = Firestore.firestore().collection("users").document(uid).collection("user-retweets")
        userSavesRef.document(tweetId).delete{ _ in
            completion()
        }
    }
    
    func CheckIfUserRetweetedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-retweets")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {
                    return
                }

                completion(snapshot.exists)
            }
    }
    
    func FetchRetweetedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void){
        var tweets = [Tweet]()
        Firestore.firestore().collection("users").document(uid)
            .collection("user-retweets")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            completion(tweets)
                        }
                }
            }
    }
}
