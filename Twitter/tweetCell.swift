//
//  tweetCell.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/4/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

// custom delegate
@objc protocol TweetCellDelegate {
    optional func tweetCellProfileImageTapped(tweetCell: tweetCell)
}


class tweetCell: UITableViewCell {
    
    var delegate: TweetCellDelegate?

    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var timeDifference: UILabel!
    @IBOutlet weak var retweetTopImage: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var retweetedByText: UILabel!
    @IBOutlet weak var retweetTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var retweetByTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var retweetByHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetImageHeight: NSLayoutConstraint!
    @IBAction func onReply(sender: AnyObject) {

    }
    
    
    var tweet: Tweet! {
        didSet {
            
            if let _ = tweet.retweet{
                
                retweetTopImage.hidden = false
                retweetedByText.hidden = false
                
                if let user = tweet.retweet!.user!.name{
                    userName.text = user
                }
                
                if let sname = tweet.retweet!.user!.screenName{
                    screenName.text = "@\(sname)"
                    
                }
                retweetTopImage.image = UIImage(named: "tweet_retweet")
                retweetedByText.text = "\(tweet.user!.name!) Retweeted"
                
                tweetText.text = tweet.retweet!.text!
                profilePic.setImageWithURL(NSURL(string : tweet.retweet!.user!.profileImageUrl!)!)
                retweetCount.text = String(tweet.retweet!.retweetCount!)
                favoriteCount.text = String(tweet.retweet!.likeCount!)
                timeDifference.text = returnDifference(tweet.retweet!.createdAt!)
                
                retweetByHeight.constant = 15
                retweetImageHeight.constant = 15
                setNeedsUpdateConstraints()
                
            }else{
                
                retweetTopImage.hidden = true
                retweetedByText.hidden = true

                
                if let user = tweet.user!.name{
                    userName.text = user
                }
                
                if let sname = tweet.user!.screenName{
                    screenName.text = "@\(sname)"
                    
                }
                
                tweetText.text = tweet.text!
                profilePic.setImageWithURL(NSURL(string : tweet.user!.profileImageUrl!)!)
                retweetCount.text = String(tweet.retweetCount!)
                favoriteCount.text = String(tweet.likeCount!)
                timeDifference.text = returnDifference(tweet.createdAt!)
                
                retweetByHeight.constant = 0
                retweetImageHeight.constant = 0
                setNeedsUpdateConstraints()
            }
            
            
            replyButton.setImage(UIImage(named: "tweet_reply"), forState: .Normal)
            retweetButton.setImage(UIImage(named: "tweet_retweet"), forState: .Normal)
            likeButton.setImage(UIImage(named: "tweet_like"), forState: .Normal)
            
            // Add the Gesture Recognizer
            profilePic.userInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: "didTapOnProfileImage:")
            profilePic.addGestureRecognizer(tapGesture)
        }
    }

    
    func returnDifference(createdAt : NSDate) -> String{
        let seconds = NSDate().timeIntervalSinceDate(createdAt)
        if(seconds < 60){
            return String("\(seconds)s")
        }else{
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
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        let count = Int(retweetCount.text!)
        retweetCount.text = String(count! + 1)
    }
 
    @IBAction func onLIke(sender: AnyObject) {
        let count = Int(favoriteCount.text!)
        favoriteCount.text = String(count! + 1)
    }
    
   
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tweetText.preferredMaxLayoutWidth = tweetText.frame.size.width
    }
    
    override func layoutSubviews() {
        // Always call the Parent SubView
        super.layoutSubviews()
        
        // Preferred Wrapping Point
        tweetText.preferredMaxLayoutWidth = tweetText.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Delegate Implementation
    func didTapOnProfileImage(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.tweetCellProfileImageTapped!(self)
    }
    
    
    

}
