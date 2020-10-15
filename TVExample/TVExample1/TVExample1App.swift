//
//  AppDelegate.swift
//  TVExample1
//
//  Created by brennobemoura on 25/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import UICreator

@main
struct TVExample1App: UICApp {
    var body: ViewScene {
        UICWindowGroup {
            UICNavigation {
                ListView()
            }
        }
    }
}

