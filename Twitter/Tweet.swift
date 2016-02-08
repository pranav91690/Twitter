//
//  Tweet.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/3/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id: String?
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    // Additional Fields
    var retweetCount : Int?
    var likeCount : Int?
    
    init(dictionary : NSDictionary){
        let userDictionary = dictionary["user"] as! NSDictionary
        user = User(dictionary : userDictionary)
        text = dictionary["text"] as? String        
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id_str"] as? String
        
        // Define a Formatter --> Formatters are expensive??...and also can make the property lazy
        let formatter =  NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        retweetCount = dictionary["retweet_count"] as? Int
        likeCount = userDictionary["favourites_count"] as? Int
    }
    
    class func tweetsWithArray(array : [NSDictionary]) -> [Tweet] {
        // Return a Array of tweets from an array of dictionary!!
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
         
        return tweets 
    }
    
}
