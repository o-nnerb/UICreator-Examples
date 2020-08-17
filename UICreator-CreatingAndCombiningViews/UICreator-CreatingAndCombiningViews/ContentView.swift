//
//  ContentView.swift
//  UICreator-CreatingAndCombiningViews
//
//  Created by brennobemoura on 23/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

class ContentView: UICView {
    var body: ViewCreator {
        UICSpacer {
            CristoRedentor()
        }
        .backgroundColor(.white)
    }
}
