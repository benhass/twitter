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

        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 250

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadTweets", forControlEvents: UIControlEvents.ValueChanged)
        tweetsTableView.insertSubview(refreshControl, atIndex: 0)
        loadTweets()
    }
    
    override func viewDidAppear(animated: Bool) {
        var indexPath = tweetsTableView.indexPathForSelectedRow()
        if indexPath != nil {
            tweetsTableView.deselectRowAtIndexPath(indexPath!, animated: false)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tweetDetailSegue" {
            var vc = segue.destinationViewController as TweetDetailViewController
            let indexPath = self.tweetsTableView.indexPathForCell(sender as TweetCell) as NSIndexPath!
            vc.tweet = tweets[indexPath.row]
        } else if segue.identifier == "userProfileSegue" {
            var vc = segue.destinationViewController as UserProfileViewController
            var tapRecognizer = sender as UIGestureRecognizer
            var point = tapRecognizer.locationInView(tweetsTableView)
            var indexPath = tweetsTableView.indexPathForRowAtPoint(point)!
            vc.user = tweets[indexPath.row].user!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadTweets() {
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.refreshControl.endRefreshing()
            self.tweetsTableView.reloadData()
        })
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
}
