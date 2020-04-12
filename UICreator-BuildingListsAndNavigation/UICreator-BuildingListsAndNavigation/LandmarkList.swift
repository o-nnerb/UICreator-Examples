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
        UICList(style: .grouped) {[
            UICForEach(landmarkData) { landmark in
                UICRow {
                    Link {
                        LandmarkRow(landmark: landmark)
                            .margin(.leading, .trailing)
                    }.destination {
                        LandmarkDetail(landmark: landmark)
                    }
                }
            }
        ]}.insets()
        .navigation(title: "Landmarks")
        .navigation(prefersLargeTitles: true)
        .accessoryType(.disclosureIndicator)
        .backgroundColor(.white)
        .separator(style: .singleLine)
    }
}

#if DEBUG

import SwiftUI

struct LandmarkList_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(LandmarkList())
    }
}

#endif
