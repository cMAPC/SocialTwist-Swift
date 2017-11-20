//
//  NavigationController.swift
//  ZipMobile
//
//  Created by Vadim on 10/11/17.
//  Copyright © 2017 Vadim. All rights reserved.
//

import UIKit

class NavigationController: NSObject {
    
//    class func topViewController() -> UIViewController {
//
//        var topController : UIViewController = topViewController(rootViewController:(UIApplication.shared.delegate as! AppDelegate).window?.rootViewController)
//
//        while (topController.presentedViewController != nil) {
//            topController = topController.presentedViewController!
//        }
//        return topController
//    }
//
//    class func topViewController (rootViewController : UIViewController?) -> UIViewController {
//
//        if let topController = rootViewController as? UINavigationController {
//
//            return topViewController(rootViewController: topController.visibleViewController)
//
//        } else if let topController = rootViewController?.presentedViewController {
//            return topViewController(rootViewController: topController.presentedViewController)
//
//        } else {
//            return rootViewController!
//        }
//    }
    
//    + (UIViewController *)topViewController {
//
//    UIViewController *topController = [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
//
//    while (topController.presentedViewController)
//    topController = topController.presentedViewController;
//
//    return topController;
//
//    }
    
    
    static func topViewController() -> UIViewController {
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            
            let topVC = topViewController(rootViewController: rootVC)
            
            return topVC
            
//            while ((topVC.presentedViewController) != nil) {
//
//                topVC = topVC.presentedViewController! as UIViewController
//
//                return topVC
//            }
            
        } else {
            
            return (UIApplication.shared.keyWindow?.rootViewController)!
        }
        
    }
    
    static func topViewController(rootViewController: UIViewController) -> UIViewController {
        
        if rootViewController is UITabBarController {
            
            let tabBarController = rootViewController as! UITabBarController
            return topViewController(rootViewController:tabBarController.selectedViewController!)
            
        } else if rootViewController is UINavigationController {
            
            let navigationController = rootViewController as! UINavigationController
            return topViewController(rootViewController:navigationController.visibleViewController!)
            
        } else if let presentedVC = rootViewController.presentedViewController {
            
            return topViewController(rootViewController:presentedVC)
            
        } else {
            
            return rootViewController
        }
        
    }
    
    
    
//
//    + (UIViewController *)topViewController:(UIViewController *)rootViewController {
//
//    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
//
//    UITabBarController* tabBarController = (UITabBarController*)rootViewController;
//    return [self topViewController:tabBarController.selectedViewController];
//
//    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
//
//    UINavigationController* navigationController = (UINavigationController*)rootViewController;
//    return [self topViewController:navigationController.visibleViewController];
//
//    } else if (rootViewController.presentedViewController) {
//
//    UIViewController* presentedViewController = rootViewController.presentedViewController;
//    return [self topViewController:presentedViewController];
//
//    } else {
//
//    return rootViewController;
//    }
//
//    }
}
