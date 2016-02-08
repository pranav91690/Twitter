//
//  tweetsViewController.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/3/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import AFNetworking

class tweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets : [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // Do any additional setup after loading the view.
        
        // Customizing the Navigation Bar Properties
        if let navigationBar = navigationController?.navigationBar{
            navigationBar.backgroundColor =  UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 10.0)
        }
        
        
        TwitterClient.sharedInstance.homeTimeLineWithCompletion(nil,
            completion: {(tweets,error) -> () in
                if let tweets = tweets{
                    // get the Tweet Details
                    self.tweets = tweets
                    self.tableView.reloadData()
                    
//                    TwitterClient.sharedInstance.tweetDetails(tweets, params: nil, completion: {(tweets,error) -> () in
//                            self.tweets = tweets
//                            self.tableView.reloadData()
//                        })
                }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! tweetCell
        
        let tweet = tweets[indexPath.row]
        
        cell.userName.text = tweet.user!.name!
        cell.tweetText.text = tweet.text!
        cell.profilePic.setImageWithURL(NSURL(string : tweet.user!.profileImageUrl!)!)
        cell.retweetCount.text = String(tweet.retweetCount!)
        cell.favoriteCount.text = String(tweet.likeCount!)
        cell.timeDifference.text = returnDifference(tweet.createdAt!)
                
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signOut(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    func returnDifference(createdAt : NSDate) -> String{
        let seconds = NSDate().timeIntervalSinceDate(createdAt)
        let minutes = Int(seconds/60)
        
        if(minutes > 59){
            let hours = Int(minutes/60)
            
            if hours > 23{
                let days = Int(hours/24)
                return String("\(days)d")
            }else{
                return String("\(hours)h")
            }
        }else{
            return String("\(minutes)m")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
