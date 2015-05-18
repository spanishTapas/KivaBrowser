//
//  AppDelegate.swift
//  KivaBrowser
//
//  Created by wanming zhang on 7/27/14.
//  Copyright (c) 2014 wanming zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        let tabBarController: UITabBarController = self.window?.rootViewController as! UITabBarController
        let loanImage = UIImage(named: "Loans")
        let teamImage = UIImage(named: "Teams")
        let lenderImage = UIImage(named: "Lenders")
        let aboutImage = UIImage(named: "About")
        let tabBar: UITabBar = tabBarController.tabBar

        tabBar.translucent = false

        if let items = tabBar.items as? [UITabBarItem] {
            let item1 = items[1]
            item1.image = loanImage

            let item3 = items[3]
            item3.image = teamImage
            //println("AppDelegate item3.selectedImage \(item3.image)")

            let item4 = items[4]
            item4.image = lenderImage
            
            let item5 = items[5]
            item5.image = aboutImage
        }
        
        return true
    }
//    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
//        // Override point for customization after application launch.
//        
//        let tabBarController: UITabBarController = self.window?.rootViewController as! UITabBarController
//        let loanImage = UIImage(named: "Loans")
//        let teamImage = UIImage(named: "Teams")
//        let lenderImage = UIImage(named: "Lenders")
//        let aboutImage = UIImage(named: "About")
//        let tabBar: UITabBar = tabBarController.tabBar
//        
//        tabBar.translucent = false
//        
//        if let items = tabBar.items as? [UITabBarItem] {
//            let item1 = items[1]
//            item1.image = loanImage
//            
//            let item3 = items[3]
//            item3.image = teamImage
//            //println("AppDelegate item3.selectedImage \(item3.image)")
//            
//            let item4 = items[4]
//            item4.image = lenderImage
//            
//            let item5 = items[5]
//            item5.image = aboutImage
//        }
//        
//        return true
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

