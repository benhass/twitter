//
//  User.swift
//  twitter
//
//  Created by Ben Hass on 2/19/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var dictionary: NSDictionary
    var name: String?
    var screenName: String?
    var profileImageUrlString: String?
    var profileImageUrl: NSURL?
    var profileImageBiggerUrlString: String?
    var profileImageBiggerUrl: NSURL?
    var profileBackgroundImageUrlString: String?
    var profileBackgroundImageUrl: NSURL?
    var tagline: String?
    var tweetCount: Int?
    var retweetCount: Int?
    var favoritesCount: Int?
    var followersCount: Int?
    var followingCount: Int?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrlString = dictionary["profile_image_url"] as? String
        profileImageUrl = NSURL(string: profileImageUrlString!)
        profileImageBiggerUrlString = profileImageUrlString!.stringByReplacingOccurrencesOfString("_normal.png", withString: "_bigger.png")
        profileImageBiggerUrl = NSURL(string: profileImageBiggerUrlString!)
        profileBackgroundImageUrlString = dictionary["profile_background_image_url"] as? String
        profileBackgroundImageUrl = NSURL(string: profileBackgroundImageUrlString!)
        
        tagline = dictionary["description"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        favoritesCount = dictionary["favourites_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}