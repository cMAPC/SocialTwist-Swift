//
//  InteractorController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/7/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

class InteractorController: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Variables
    
    var interactionInProgress = false
    var shouldCompleteTransaction = false
    
    
    private weak var viewController: UIViewController!
    private weak var tableView: UITableView!
    
    // MARK: - Object life cycle
    
    init(viewController: UIViewController, tableView: UITableView) {
        super.init()
        self.viewController = viewController
        self.tableView = tableView
        prepareGestureRecognizer()
    }
    
    // MARK: - Gesture
    
    private func prepareGestureRecognizer() {
        tableView.panGestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
    }
    
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let percentThreshold: CGFloat = 0.3
        
        let translation = gestureRecognizer.translation(in: tableView)
        let verticalMovement = translation.y / UIScreen.main.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        let velocity = gestureRecognizer.velocity(in: tableView)
        
//        print("Content offset \(tableView.contentOffset.y)")
//        print("Vertical movement \(verticalMovement)")
//        print("Translation \(gestureRecognizer.location(in: tableView).y)")
//        print("Content insets \(tableView.contentInset.bottom)")
//        print("Progress \(progress)")
//        print("Velocity \(velocity.y)")

        if tableView.contentOffset.y <= 0 {
            switch gestureRecognizer.state {
                
            case .began:
                interactionInProgress = true
                if  velocity.y < 0 {
                    break
                } else {
                    viewController.dismiss(animated: true, completion: nil)
                }

            case .changed:
                shouldCompleteTransaction = progress > percentThreshold
                update(progress)
                
            case .cancelled:
                interactionInProgress = false
                cancel()
                
            case .ended:
                interactionInProgress = false
                shouldCompleteTransaction ? finish() : cancel()

            default:
                break
            }
        }
    }
    
}
