//
//  UITextField.swift
//  SocialTwist
//
//  Created by Marcel  on 10/20/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    var isEmpty: Bool {
        return self.text?.isEmpty ?? true
    }
    
    func showWarning() -> Void {
        let rightView = UIImageView (frame: CGRect (x: 0, y: 0, width: 20, height: 20))
        rightView.image = #imageLiteral(resourceName: "warning")
        self.rightViewMode = .always
        self.rightView = rightView
        self.rightView?.isHidden = false
    }
    
    func dismissWarning() -> Void {
        self.rightView?.isHidden = true
    }
}

