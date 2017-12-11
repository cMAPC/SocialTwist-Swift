//
//  CustomPresentAnimationController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/4/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.0,
            options: .curveLinear,
            animations: {

                toViewController.view.layer.cornerRadius = 6.0
                toViewController.view.frame = CGRect(x: 0, y: 40, width: finalFrameForVC.width, height: finalFrameForVC.height)
                fromViewController?.view.alpha = 0.5
                
//                fromViewController?.view.alpha = 0.5
//                toViewController.view.frame = finalFrameForVC

        }) { finished in
            toViewController.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
}
