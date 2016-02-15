//
//  tweetDetailViewController.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/14/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

class tweetDetailViewController: UIViewController {
    
    // Tweet Details
    // To Store the actual tweet information
    var tweet: Tweet!
    
    // Outlets
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    //Actions
    
    @IBAction func onReply(sender: AnyObject) {
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
    }
    
    @IBAction func onLike(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetText.text = tweet.text!
        profilePic.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        userName.text = tweet.user!.name!
        screenName.text = "@\(tweet.user!.screenName!)"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.stringFromDate(tweet.createdAt!)
        timeStamp.text = dateString
        
        replyButton.setImage(UIImage(named: "tweet_reply"), forState: .Normal)
        retweetButton.setImage(UIImage(named: "tweet_retweet"), forState: .Normal)
        likeButton.setImage(UIImage(named: "tweet_like"), forState: .Normal)
        retweetCount.text = String(tweet.retweetCount!)
        likeCount.text = String(tweet.likeCount!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
