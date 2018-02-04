//
//  SizeManager.swift
//  SmartPromo
//
//  Created by Marcel  on 1/26/18.
//  Copyright © 2018 Marcel . All rights reserved.
//

import Foundation
import UIKit

class SizeManager: NSObject {
    
    class func height(height: Float, reference: UIDevice.DeviceType) -> CGFloat {
        
        var referenceHeight : Float = 0.0
        
        switch reference {
            
        case .iPhone35:
            referenceHeight = 480
            
        case .iPhone40:
            referenceHeight = 568
            
        case .iPhone47:
            referenceHeight = 667
            
        case .iPhone55:
            referenceHeight = 736
            
        case .iPhone58:
            referenceHeight = 812
        }
        
        let percentage = height * 100 / referenceHeight
        let newHeight = Float (UIScreen.main.bounds.height) * percentage / 100
        
        return CGFloat (newHeight)
    }
    
    class func width(width: Float, reference: UIDevice.DeviceType) -> CGFloat {
        
        var referenceWidth: Float = 0.0
        
        switch reference {
            
        case .iPhone35:
            referenceWidth = 320
            
        case .iPhone40:
            referenceWidth = 320
            
        case .iPhone47:
            referenceWidth = 375
            
        case .iPhone55:
            referenceWidth = 414
            
        case .iPhone58:
            referenceWidth = 375
        }
        
        
        let percentage = width * 100 / referenceWidth
        let newWidth = Float (UIScreen.main.bounds.width) * percentage / 100
        
        return CGFloat (newWidth)
    }
}



//MARK: - UIDevice Extension

extension UIDevice {
    
    enum DeviceType {
        case iPhone35
        case iPhone40
        case iPhone47
        case iPhone55
        case iPhone58
    }
    
    static class var deviceType: DeviceType {
        
        switch UIScreen.main.bounds.height {
            
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
