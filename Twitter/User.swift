//
//  User.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/3/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import SwiftyJSON

var _currentUser : User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name : String?
    var screenName: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    func logout(){
        // Clear the Current User
        User.currentUser = nil
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        // use NsNotifications -- used to subscribe to global events and keep monitoring them
        
        // tell anybody interested that this logout event happened
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
    }
    
    // This is a hack to circumvent the notion of not having class(is it static??) variables in Swift??
    class var currentUser : User?{
        get{
            if _currentUser == nil{ // It can mean there is no current user or we just booted up
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil{
                    // We should get the persistent data
                    do{
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
        
                    }catch let error as NSError{
                        //handle error
                        print("Error : \(error)")
                    }
                }
        
            }
        
        
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            if _currentUser != nil{
                do{
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions(rawValue: 0))
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                }catch let error as NSError{
                    //handle error
                    print("Error : \(error)")
                }
            }else{
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
