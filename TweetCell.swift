//
//  TweetCell.swift
//  
//
//  Created by Ben Hass on 2/21/15.
//
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    var _tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5
        profileImageView.userInteractionEnabled = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var tweet: Tweet {
        get {
            return self._tweet
        }
        set(tweet) {
            self._tweet = tweet
            profileImageView.setImageWithURL(tweet.user!.profileImageBiggerUrl)
            userNameLabel.text = tweet.user?.name
            userScreenNameLabel.text = "@\(tweet.user!.screenName!)"
            tweetLabel.text = tweet.text
            timestampLabel.text = tweet.timestamp
        }
    }
    
}
