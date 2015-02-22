//
//  ComposeTweetViewController.swift
//  twitter
//
//  Created by Ben Hass on 2/21/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {
    
    @IBOutlet weak var tweetTextView: UITextView!
    var originalTweetForReply: Tweet?
    var tweetParams: NSMutableDictionary = ["status": ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if originalTweetForReply != nil {
            tweetParams["in_reply_to_status_id"] = originalTweetForReply!.id
            tweetTextView.text = "@\(originalTweetForReply!.user!.screenName!) "
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        tweetParams["status"] = tweetTextView.text
        TwitterClient.sharedInstance.createTweet(tweetParams, completion:  { (tweet, error) -> () in
            if error == nil {
                println(tweet!.text)
                self.tweetTextView.text = ""
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                println("error creating tweet")
            }
        })
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        tweetTextView.text = ""
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
