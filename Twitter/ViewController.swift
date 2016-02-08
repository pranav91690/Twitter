//
//  ViewController.swift
//  Twitter
//
//  Created by Pranav Achanta on 2/2/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager


class ViewController: UIViewController {

    
    @IBAction func onLoginTwitter(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user : User?, error : NSError?) in
            if user != nil{
                // Perform Modal
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("tweetsViewController") as! tweetsViewController
                let navController = UINavigationController(rootViewController: vc)
                self.presentViewController(navController, animated:true, completion: nil)
            }else{
                //handle error
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

