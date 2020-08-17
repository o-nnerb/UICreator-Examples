//
//  AppDelegate.swift
//  Teste1
//
//  Created by brennobemoura on 18/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import UIKit
import UICreator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UICHostingController {
            ContentView()
        }
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}

