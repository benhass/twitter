//
//  MenuViewController.swift
//  twitter
//
//  Created by Ben Hass on 2/28/15.
//  Copyright (c) 2015 benhass. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    var containerOriginalCenter: CGPoint!
    var originalTapCenter: CGPoint!
    var containerHiddenX: CGFloat!
    var containerShowX: CGFloat!
    var containerMiddleX: CGFloat!
    var containerLastX: CGFloat!
    
    var velocity: CGFloat!
    private var homeNavVC: UINavigationController!
    private var mentionsNavVC: UINavigationController!
    private var profileVC: UserProfileViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeNavVC = self.storyboard!.instantiateViewControllerWithIdentifier("TweetsNavController") as UINavigationController
        (homeNavVC.topViewController as TweetsViewController).timeline = "home"
        mentionsNavVC = self.storyboard!.instantiateViewControllerWithIdentifier("TweetsNavController") as UINavigationController
        (mentionsNavVC.topViewController as TweetsViewController).timeline = "mentions"

        profileVC = self.storyboard!.instantiateViewControllerWithIdentifier("UserProfileViewController") as UserProfileViewController
        profileVC.user = User.currentUser!
        
        containerShowX = (containerView.frame.width / 2)
        containerHiddenX = containerShowX + (containerView.frame.width * (3/4))
        containerMiddleX = containerHiddenX - containerShowX
        showDefaultVC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapHome(sender: UIButton) {
        hideMenu()
        showDefaultVC()
    }
    
    @IBAction func onTapMentions(sender: UIButton) {
        hideMenu()
        mentionsNavVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(mentionsNavVC.view)
        self.view.bringSubviewToFront(self.containerView)
    }
    
    @IBAction func onTapProfile(sender: UIButton) {
        hideMenu()
        profileVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(profileVC.view)
        self.view.bringSubviewToFront(self.containerView)
    }
    
    @IBAction func onTapSignOut(sender: UIButton) {
        hideMenu()
        User.currentUser?.logout()
    }
    
    @IBAction func onDragContainerView(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(self.view)
        var velocity = sender.velocityInView(self.view)

        if sender.state == UIGestureRecognizerState.Began {
            containerOriginalCenter = containerView.center
            containerLastX = containerView.center.x
            originalTapCenter = point
        } else if sender.state == UIGestureRecognizerState.Changed {
            var newX = point.x + (containerOriginalCenter.x - originalTapCenter.x)
            containerLastX = containerView.center.x
            containerView.center.x = newX
        } else if sender.state == UIGestureRecognizerState.Ended {
            if (velocity.x < -50.0 || velocity.x > 50.0) {
                setMenuStateByIntention(velocity)
            } else {
                setMenuStateByPosition()
            }
        }
    }
    
    func showDefaultVC() {
        homeNavVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(homeNavVC.view)
        self.view.bringSubviewToFront(self.containerView)
    }
    
    func setMenuStateByIntention(velocity: CGPoint) {
        if containerView.center.x > containerLastX {
            showMenu()
        } else {
            hideMenu()
        }
    }
    
    func setMenuStateByPosition() {
        if containerView.center.x <= containerMiddleX {
            hideMenu()
        } else if containerView.center.x > containerMiddleX {
            showMenu()
        }
    }
    
    func showMenu() {
        containerView.center.x = containerHiddenX
    }
    
    func hideMenu() {
        containerView.center.x = containerShowX
    }
    
}
