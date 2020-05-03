//
//  ContentView.swift
//  UICreator-Tests
//
//  Created by brennobemoura on 23/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator
import UIContainer

class ContentView: UICView {
    var body: ViewCreator {
        UICSpacer {
            UICNavigation {
                UICTab {[
                    UICTabItem(title: "Group 1") {
                        UICSpacer()
                            .backgroundColor(.red)
                    },
                    UICTabItem(title: "Group 2") {
                        UICSpacer()
                            .backgroundColor(.yellow)
                    },
                    UICTabItem(title: "Group 3") {
                        UICSpacer()
                            .backgroundColor(.black)
                    }
                ]}
            }
        }
    }
}
