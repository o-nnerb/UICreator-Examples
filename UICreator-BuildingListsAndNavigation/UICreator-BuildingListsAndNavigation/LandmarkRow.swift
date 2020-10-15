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

class LandmarkRow: UICView {
    @Value var isPushing: Bool = false
    @Property(\.sizeCategory) var sizeCategory

    let landmark: Landmark

    init(landmark: Landmark) {
        self.landmark = landmark
    }

    var body: ViewCreator {
        UICNavigationLink(self.$isPushing) { [unowned self] in
            LandmarkDetail(landmark: landmark)
        } content: {
            UICSpacer(vertical: 5) { [unowned self] in
                UICHStack {
                    UICCenter {
                        UICImage(image: self.landmark.image)
                            .aspectRatio()
                            .height(equalTo: 50)
                            .content(mode: .scaleAspectFill)
                            .clipsToBounds(true)
                            .insets(.leading, .trailing)
                    }

                    UICLabel(self.landmark.name)
                        .font(.body)
                        .vertical(hugging: .defaultHigh, compression: .required)
                        .numberOfLines(.zero)

                    UICSpacer()
                        .isHidden(self.$sizeCategory.map { $0 >= .accessibilityMedium })
                }
                .spacing(15)
            }
            .onTap { _ in
                self.isPushing = true
            }
            .dynamicProperty(self._sizeCategory)
        }
    }
}

#if DEBUG && UICREATOR_SUIPREVIEWS

import SwiftUI

struct LandmarkRow_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(LandmarkRow(landmark: landmarkData[0]))
    }
}

#endif
