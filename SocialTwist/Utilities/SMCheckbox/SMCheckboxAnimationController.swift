//
//  SMCheckboxAnimationController.swift
//  SMCheckBox
//
//  Created by Marcel  on 11/13/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

class SMCheckboxAnimationController {
    
    func fillAnimation(key: String, reverse: Bool) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation (keyPath: key)
        
        var values = [CATransform3D]()
        var keyTimes = [Float]()
        
//        if !reverse {
//            values.append(CATransform3DMakeScale(0.1, 0.1, 0.1))
//            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
//        } else {
//            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
//            values.append(CATransform3DMakeScale(0.00001, 0.00001, 0.00001))
//        }
        
//        keyTimes.append(0.0)
//        keyTimes.append(1.0)
        
        
        let numberOfBounces = 1
        let amplitude: CGFloat = 0.20
        
        // Start scale
        if !reverse {
            values.append(CATransform3DMakeScale(0.0, 0.0, 0.0))
        } else {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        }
        
        keyTimes.append(0.0)
        
        // Bounces
        for i in 1...numberOfBounces {
            let scale = i % 2 == 1 ? (1.0 + (amplitude / CGFloat(i))) : (1.0 - (amplitude / CGFloat(i)))
            let time = Float(i) / Float(numberOfBounces + 1)
            
            values.append(CATransform3DMakeScale(scale, scale, scale))
            keyTimes.append(time)
        }
        
        keyTimes.append(1.0)
        
        // End scale
        if !reverse {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        } else {
            values.append(CATransform3DMakeScale(0.00001, 0.00001, 0.00001))
        }

        animation.values = values
        animation.keyTimes = keyTimes.map{ NSNumber(value: $0 as Float) }
        animation.duration = 0.3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
}
