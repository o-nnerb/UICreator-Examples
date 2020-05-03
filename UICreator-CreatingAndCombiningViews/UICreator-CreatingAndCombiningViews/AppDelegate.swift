//
//  AppDelegate.swift
//  UICreator-CreatingAndCombiningViews
//
//  Created by brennobemoura on 23/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UICreator
import UIContainer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UICHostingView {
            ContentView()
        }
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}

