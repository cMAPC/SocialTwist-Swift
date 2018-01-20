//
//  UIColorConstants.swift
//  SocialTwist
//
//  Created by Marcel  on 11/16/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct TwistPalette {
        static let FlatBlue = UIColor(red: 171.0/255.0, green: 197.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        static let FlatGray = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        static let DarkGray = UIColor(red: 169.0/255.0, green: 169.0/255.0, blue: 169.0/255.0, alpha: 1.0)
        static let MiddleGray = UIColor(red: 199.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        static let LowGray = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    }
    
    open class var randomColor: UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
}
