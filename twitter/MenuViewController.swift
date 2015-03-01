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
    private var homeVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeVC = storyboard.instantiateViewControllerWithIdentifier("TweetsNavController") as UIViewController
        
        containerShowX = (containerView.frame.width / 2)
        containerHiddenX = containerShowX + (containerView.frame.width * (3/4))
        containerMiddleX = containerHiddenX - containerShowX
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapHome(sender: UIButton) {
        showDefaultVC()
    }
    
    @IBAction func onTapMentions(sender: UIButton) {
        
    }
    
    @IBAction func onTapProfile(sender: UIButton) {
        //profileVC.view.frame = self.containerView.bounds
        //self.containerView.addSubview(profileVC.view)
    }
    
    @IBAction func onTapSignOut(sender: UIButton) {
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
        homeVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(homeVC.view)
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
