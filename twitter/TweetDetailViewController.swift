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

        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5
        profileImageView.userInteractionEnabled = true
        
        // Do any additional setup after loading the view.
        userNameLabel.text = tweet.user?.name
        userScreenNameLabel.text = "@\(tweet.user!.screenName!)"
        tweetLabel.text = tweet.text
        timestampLabel.text = tweet.timestamp
        profileImageView.setImageWithURL(tweet.user!.profileImageBiggerUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPressRetweet(sender: AnyObject) {
        var params = ["id": tweet.id!]
        TwitterClient.sharedInstance.createRetweet(params, completion: { (tweet, error) -> () in
            println("retweeted")
        })
    }
    
    @IBAction func onPressFavorite(sender: AnyObject) {
        var params = ["id": tweet.id!]
        TwitterClient.sharedInstance.createFavorite(params, completion: { (tweet, error) -> () in
            println("favorited")
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "composeRetweetSegue" {
            var vc = segue.destinationViewController as ComposeTweetViewController
            vc.originalTweetForReply = tweet
        } else if segue.identifier == "userProfileSegue" {
            var vc = segue.destinationViewController as UserProfileViewController
            vc.user = tweet.user!
        }
    }
}
