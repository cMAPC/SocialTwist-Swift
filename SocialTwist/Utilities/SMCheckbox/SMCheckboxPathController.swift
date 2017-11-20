//
//  SMCheckboxPathController.swift
//  SMCheckBox
//
//  Created by Marcel  on 11/16/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

class SMCheckboxPathController {
    
    //----------------------------
    // MARK: - Properties
    //----------------------------
    
    var size: CGFloat = 0.0
    var boxLineWidth: CGFloat = 0.0
    
    //----------------------------
    // MARK: - Paths
    //----------------------------
    
    func pathForCircle() -> UIBezierPath {
        let radius = (size - boxLineWidth) / 2.0
        return UIBezierPath (arcCenter: CGPoint (x: size / 2.0, y: size / 2.0),
                             radius: radius,
                             startAngle: -CGFloat.pi,
                             endAngle: CGFloat.pi,
                             clockwise: true)
    }
    
    func pathForMark() -> UIBezierPath {
        let transform = CGAffineTransform(scaleX: 0.665, y: 0.665)
        let translate = CGAffineTransform(translationX: size * 0.1675, y: size * 0.1675)
        let path = pathForCircle()
        path.apply(transform)
        path.apply(translate)
        return path
    }
}
