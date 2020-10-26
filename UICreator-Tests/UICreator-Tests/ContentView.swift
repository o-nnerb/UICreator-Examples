//
//  ContentView.swift
//  UICreator-Tests
//
//  Created by brennobemoura on 23/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

struct ContentView: UICView {
    var body: ViewCreator {
        UICNavigation {
            CollectionView()
        }
        .eraseToAnyView()
        .backgroundColor(.white)
    }
}
