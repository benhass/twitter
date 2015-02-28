//
//  UserProfileViewController.swift
//  
//
//  Created by Ben Hass on 2/28/15.
//
//

import UIKit

class UserProfileViewController: UIViewController {
    var _user: User!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5
        profileImageView.userInteractionEnabled = true
    }
    
    override func viewWillAppear(animated: Bool) {
        userNameLabel.text = user.name
        userScreenNameLabel.text = "@\(user.screenName!)"
        profileBackgroundImageView.setImageWithURL(user.profileBackgroundImageUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var user: User {
        get {
            return self._user
        }
        set(user) {
            self._user = user
        }
    }

}