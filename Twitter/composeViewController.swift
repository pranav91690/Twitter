//
//  composeViewController.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/14/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

protocol returnTweetDelegate{
    func returnTweet(tweet : Tweet?)
}

class composeViewController: UIViewController {
    var currentUser : User!
    var delegate : returnTweetDelegate?
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    
    //Actions
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func postTweet(sender: AnyObject) {
        let text = tweetText.text!
        
        // Post this tweet!!
        TwitterClient.sharedInstance.postTweet(text,
            completion: {(tweet,error) -> () in
                self.delegate?.returnTweet(tweet)
                self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        userProfilePic.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
