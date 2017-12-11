//
//  DismissAnimationController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/7/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

class DismissAnimationController: NSObject {
    let interactionController: InteractorController?

    init(interactionController: InteractorController?) {
        self.interactionController = interactionController
    }
}

extension DismissAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshot)
        snapshot.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        fromVC.view.isHidden = true
        toVC.view.alpha = 0.5

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot.center.y += UIScreen.main.bounds.height
                toVC.view.alpha = 1.0
        }) { _ in
            fromVC.view.isHidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
