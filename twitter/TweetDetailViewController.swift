//
//  TweetDetailViewController.swift
//  twitter
//
//  Created by Ben Hass on 2/21/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.setImageWithURL(tweet.user?.profileImageBiggerUrl)
        userNameLabel.text = tweet.user?.name
        userScreenNameLabel.text = tweet.user?.screenName
        tweetLabel.text = tweet.text
        timestampLabel.text = tweet.timestamp
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressHome(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onPressReply(sender: AnyObject) {
        performSegueWithIdentifier("composeTweetSegue", sender: self)
    }
}
