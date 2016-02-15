//
//  userDetailViewController.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/14/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

class userDetailViewController: UIViewController {
    
    var user : User!
    
    //Outlets
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        userName.text = user.name!
        screenName.text = "@\(user.screenName!)"
        userDescription.text = user.tagline!
        if(user.followers! > 999 && user.followers! < 1000000){
            followersCount.text = String("\(Double(user.followers!/1000))k")
        }else if user.followers! >= 1000000 {
            followersCount.text = String("\(Double(user.followers!/1000000))M")
        }else{
            followersCount.text = String(user.followers!)
        }
        
        
        followingCount.text = String(user.following!)
        
        // Do any additional setup after loading the view.
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
