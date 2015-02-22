//
//  TweetsViewController.swift
//  twitter
//
//  Created by Ben Hass on 2/19/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweets: [Tweet]! = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 100
        tweetsTableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadTweets", forControlEvents: UIControlEvents.ValueChanged)
        tweetsTableView.insertSubview(refreshControl, atIndex: 0)
        
        loadTweets()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTweets() {
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion:  { (tweets, error) -> () in
            self.tweets = tweets
            self.refreshControl.endRefreshing()
            self.tweetsTableView.reloadData()
        })
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
}
