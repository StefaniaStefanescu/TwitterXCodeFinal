//
//  TweetsRowView.swift
//  Twitter
//
//  Created by Andrei Mareși on 15.06.2022.
//

import SwiftUI
import Kingfisher

struct TweetsRowView: View {
    @ObservedObject var viewModel: TweetRowViewModel
    init(tweet: Tweet){
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            //img de profil+ info user+tweet
            if let user = viewModel.tweet.user
            {
                HStack(alignment: .top, spacing: 12){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        
                    //informatii user si tweet-uri
                    VStack(alignment: .leading, spacing: 4){
                        //user info
                       
                            HStack{
                                Text(user.fullname)
                                    .font(.subheadline).bold()
                                Text("@\(user.username)")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                Text("\(viewModel.tweet.timestamp.dateValue().formatted(date: .numeric, time: .omitted))")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                
                            }
                        
                        Text(viewModel.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        
                    }
                    
                    
                }
            }
            //action buttons
            HStack {
                Button{
                    
                } label:{
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                Spacer()   //sf symbols pt imagini
                Button{
                    viewModel.tweet.didRetweet ?? false ? viewModel.delretweet() : viewModel.retweet()
                } label:{
                    Image(systemName: viewModel.tweet.didRetweet ?? false ? "arrow.2.squarepath" : "arrow.2.squarepath")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didRetweet ?? false ? .blue : .gray )
                    
                }
                Spacer()
                Button{
                    viewModel.tweet.didlike ?? false ? viewModel.unlikeTweet() : viewModel.likeTweet()
                } label:{
                    Image(systemName: viewModel.tweet.didlike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didlike ?? false ? .red : .gray)
                    
                    
                }
                Spacer()
                Button{
                    //save tweet -->tonight
                    //viewModel.saveTweet()
                    viewModel.tweet.didSave ?? false ? viewModel.unsaveTweet() : viewModel.saveTweet()
                } label:{
                    Image(systemName: viewModel.tweet.didSave ?? false  ? "bookmark.fill" : "bookmark")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didSave ?? false ? .yellow : .gray )
                    
                }
                
                .padding()
                .foregroundColor(.gray)
                //Divider()
                
                
            }
            .overlay(Divider().offset(x: 0 , y: 16))
            
            //.padding()
            
        }
    }
}

//struct TweetsRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetsRowView()
//    }
//}
