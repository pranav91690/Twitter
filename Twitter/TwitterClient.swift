//
//  TwitterClient.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/2/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


// API Keys
let twitterConsumerKey = "e403534FLWvlYTuN2EOj8frCL"
let twitterSecretKey = "00WMoZMUq1S2RPP5tY3ox93jqi01MHarNkKUgeK4aNZetaxmFO"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    var loginCompletion : ((user : User?, error : NSError?) -> ())?
    
    // Create a Singleton class here --> so that you can use it from anywhere you want
    
    // Swift doesnt support type(static) properties --> they only support computed properties
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL!, consumerKey: twitterConsumerKey, consumerSecret: twitterSecretKey)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion : (user : User?, error : NSError?) -> ()){
        // Save the completion block to use later
        loginCompletion = completion
        
        // Step 1 -- Fetch the request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil,
            success: {(requestToken : BDBOAuth1Credential!) -> Void in
                print("got the request token")
                let authURL = NSURL(string :"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                UIApplication.sharedApplication().openURL(authURL)
                
            })
            {(error : NSError!) -> Void in
                print("Error in getting request token")
                self.loginCompletion?(user:nil, error: error)
        }
        
    }
    

    func homeTimeLineWithCompletion(params : NSDictionary?, completion : ([Tweet]?, error : NSError?) -> ()){
        GET("https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: params, progress: nil,
            success: { (operation : NSURLSessionDataTask?, response : AnyObject?) -> Void in
                
                // Get Addiitonal Info about the tweets
                let tweets = Tweet.tweetsWithArray((response as! [NSDictionary]))
                
                completion(tweets, error: nil)
                
            }) { (operation : NSURLSessionDataTask?, error : NSError) -> Void in
                print("Error getting current user's tweets")
                completion(nil, error : error)
        }
    }
    
    // Post the Tweet to the User's timeline
    func postTweet(tweetText : String, completion : (Tweet? , error : NSError?) -> ()){
        let params = ["status" : tweetText]
        POST("/1.1/statuses/update.json", parameters: params, progress: nil,
            success: { (operation : NSURLSessionDataTask?, response : AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet, error: nil)
            }) {(operation : NSURLSessionDataTask?, error : NSError) -> Void in
                completion(nil, error: error)
        }
    }
    
    
    func openURL(url : NSURL){
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query!),
            success: {(accessToken : BDBOAuth1Credential!) -> Void in
                print("Receievd Access Token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET("https://api.twitter.com/1.1/account/verify_credentials.json", parameters: nil, progress: nil,
                    success: { (operation : NSURLSessionDataTask?, response : AnyObject?) -> Void in
                        
                        let user = User(dictionary : response as! NSDictionary)
                        print("User : \(user.name!)")
                        
                        // Set the Current user to allow it to persist
                        User.currentUser = user
                        
                        self.loginCompletion?(user:user, error:nil)
                        
                    }) { (operation : NSURLSessionDataTask?, error : NSError) -> Void in
                        print("Error getting current user")
                }
            }){(error : NSError!) -> Void in
                print("Error in getting access token")
                self.loginCompletion?(user:nil, error:error)
        }
    }
}
