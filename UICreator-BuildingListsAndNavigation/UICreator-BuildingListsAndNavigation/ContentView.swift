//
//  ContentView.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 23/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

class ContentView: UICView {
    var body: ViewCreator {
        UICNavigation {
            LandmarkList()
        }
        .backgroundColor(.white)
    }
}
