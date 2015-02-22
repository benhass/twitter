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
        userScreenNameLabel.text = "@\(tweet.user!.screenName!)"
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
    
    @IBAction func onPressReply(sender: AnyObject) {
        performSegueWithIdentifier("composeTweetSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "composeTweetSegue" {
            var vc = segue.destinationViewController as ComposeTweetViewController
            vc.originalTweetForReply = tweet
        }
    }
}
