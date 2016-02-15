//
//  tweetsViewController.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/3/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import AFNetworking

class tweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate, returnTweetDelegate {
    
    var tweets : [Tweet]!
    var tweetIds : String!
    var currentTweet: Tweet!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func createNewTweet(sender: AnyObject) {
        
    }
    
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
        
        
        let apiInstance = TwitterClient.sharedInstance
        
        apiInstance.homeTimeLineWithCompletion(nil,
            completion: {(tweets,error) -> () in
                if let tweets = tweets{
                    // get the Tweet Details
                    self.tweets = tweets
                    self.tableView.reloadData()
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
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
                
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signOut(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    @objc func tweetCellProfileImageTapped(tCell: tweetCell) {
        self.currentTweet = tCell.tweet
        self.performSegueWithIdentifier("userDetailSegue", sender: self)
    }
    
    func returnTweet(tweet: Tweet?) {
        // Add the Tweet to this!!
        if let tweet = tweet{
            tweets.insert(tweet, atIndex: 0)
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepareForSegue(segue, sender: sender)
        
        if (segue.identifier == "composeSegue"){
            let vc = segue.destinationViewController as! composeViewController
            vc.delegate = self
        }else if (segue.identifier == "tweetDetailSegue") {
            let cell = sender as! tweetCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let vc = segue.destinationViewController as! tweetDetailViewController
            
            vc.tweet = tweet
        } else if (segue.identifier == "userDetailSegue") {
            let vc = segue.destinationViewController as! userDetailViewController
            vc.user = currentTweet.user!
        }
    }


}
