//
//  UIBarButtonItem+CustomStyle.swift
//  SocialTwist
//
//  Created by Marcel  on 1/21/18.
//  Copyright © 2018 Marcel . All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    class var backButtonItemWithoutTitle: UIBarButtonItem {
        return UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}
