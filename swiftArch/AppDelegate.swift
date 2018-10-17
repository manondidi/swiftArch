//
//  AppDelegate.swift
//  swiftArch
//
//  Created by czq on 2018/4/13.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import CocoaLumberjack
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.makeKeyAndVisible()
        //日志隔离级别
        DDLog.add(DDTTYLogger.sharedInstance, with: DDLogLevel.verbose)
        
        
        return true
    }

}

