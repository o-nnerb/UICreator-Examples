//
//  LandmarkRow.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator
import UIKit

struct LandmarkRow: UICView {
    @Value var isPushing: Bool = false

    let landmark: Landmark

    init(landmark: Landmark) {
        self.landmark = landmark
    }

    var body: ViewCreator {
        UICNavigationLink(destination: LandmarkDetail(landmark: landmark)) {
            UICSpacer(vertical: 5) {
                UICHStack(spacing: 15) {
                    UICCenter {
                        UICImage(uiImage: self.landmark.image)
                            .aspectRatio()
                            .height(equalTo: 50)
                            .contentMode(.fill)
                            .clipsToBounds(true)
                            .insets(.leading, .trailing)
                    }

                    UICLabel(self.landmark.name)
                        .font(.body)
                        .vertical(hugging: .defaultHigh, compression: .required)
                        .numberOfLines(.zero)
                }
            }
        }
    }
}
