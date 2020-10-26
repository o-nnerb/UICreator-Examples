//
//  LandmarkList.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

class LandmarkList: UICView {

    var body: ViewCreator {
        UICList(.grouped) {
            UICForEach(landmarkData) { landmark in
                UICRow {
                    LandmarkRow(landmark: landmark)
                        .margin(.leading, .trailing)
                }
            }
        }
        .navigation(title: "Landmarks")
        .navigation(prefersLargeTitles: true)
        .accessoryType(.disclosureIndicator)
        .backgroundColor(.white)
        .separatorStyle(.singleLine)
    }
}
