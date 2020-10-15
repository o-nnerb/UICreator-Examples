//
//  LandmarkDetail.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UICreator
import UIKit

class LandmarkDetail: UICView {
    @Property(\.sizeCategory) var sizeCategory

    let landmark: Landmark

    init(landmark: Landmark) {
        self.landmark = landmark
    }

    var body: ViewCreator {
        UICZStack { [unowned self] in
            UICVStack {
                MapView(coordinate: self.landmark.locationCoordinate)
                    .leading()
                    .height(equalTo: 300)

                UICZStack {
                    UICCenter {
                        CircleImage(image: self.landmark.image)
                            .insets(.top)
                            .height(equalTo: 260)
                    }
                    .top(equalTo: -130)
                }

                UICSpacer()
                    .height(equalTo: 15)

                UICVStack {
                    UICLabel(self.landmark.name)
                        .font(.title1)

                    UICHStack {
                        UICLabel(self.landmark.city)
                            .font(.subheadline)

                        UICSpacer()
                            .isHidden(self.$sizeCategory.map { $0 >= .accessibilityMedium })

                        UICLabel(self.landmark.country)
                            .font(.subheadline)
                    }
                    .axis(self.$sizeCategory.map { $0 >= .accessibilityMedium ? .vertical : .horizontal })
                }
                .safeArea(leadingEqualTo: 15)

                UICSpacer()
            }
            .alignment(.center)
            .safeArea(.top)
            .insets(.leading, .trailing, .bottom)
        }
        .backgroundColor(.white)
        .navigation(title: landmark.name)
        .navigation(largeTitleMode: .never)
        .dynamicProperty(self._sizeCategory)
    }
}

#if DEBUG && UICREATOR_SUIPREVIEWS

import SwiftUI

struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(LandmarkDetail(landmark: landmarkData[0]))
            .edgesIgnoringSafeArea(.all)
    }
}

#endif
