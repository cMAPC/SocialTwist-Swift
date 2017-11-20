//
//  AlertManager.swift
//  SocialTwist
//
//  Created by Marcel  on 10/23/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    static func showAlert(title: String, message: String) -> Void {
        
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        NavigationController.topViewController().present(alertController, animated: true, completion: nil)
    }
    
}
