//
//  tweetCell.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/4/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!

    @IBOutlet weak var timeDifference: UILabel!
    
    @IBAction func onReply(sender: AnyObject) {

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
    
    
    
    

}
