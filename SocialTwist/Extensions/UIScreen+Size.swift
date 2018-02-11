//
//  UIScreen+Size.swift
//  SocialTwist
//
//  Created by Marcel  on 2/9/18.
//  Copyright © 2018 Marcel . All rights reserved.
//

import Foundation
import UIKit

public extension UIScreen {
    
    enum SizeType {
        case iPhone35
        case iPhone40
        case iPhone47
        case iPhone55
        case iPhone58
    }
    
    static public var size: SizeType {
        
        switch self.main.bounds.height {
            
        case 480:
            return .iPhone35
            
        case 568:
            return .iPhone40
            
        case 667:
            return .iPhone47
            
        case 736:
            return .iPhone55
            
        case 812:
            return .iPhone58
            
        default:
            return .iPhone47
        }
    }
}
