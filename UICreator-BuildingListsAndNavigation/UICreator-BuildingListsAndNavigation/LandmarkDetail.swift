//
//  LandmarkDetail.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

class LandmarkDetail: UICView {
    let landmark: Landmark

    init(landmark: Landmark) {
        self.landmark = landmark
        super.init()
    }

    var body: ViewCreator {
        UICZStack {[
            UICVStack {[
                MapView(coordinate: self.landmark.locationCoordinate)
                    .leading()
                    .height(equalTo: 300),

                UICZStack {[
                    UICCenter {
                        CircleImage(image: self.landmark.image)
                            .insets(.top)
                            .height(equalTo: 260)
                    }.top(equalTo: -130)
                ]},

                UICSpacer()
                    .height(equalTo: 15),

                UICVStack {[
                    UICLabel(self.landmark.name)
                        .font(.title1),
                    UICHStack {[
                        UICLabel(self.landmark.city)
                            .font(.subheadline),
                        UICSpacer(),
                        UICLabel(self.landmark.country)
                            .font(.subheadline)
                    ]}
                ]}.safeArea(leadingEqualTo: 15),

                UICSpacer()
            ]}
            .alignment(.center)
            .safeArea(.top)
            .insets(.leading, .trailing, .bottom)
        ]}
        .background(color: .white)
        .navigation(title: landmark.name)
        .navigation(largeTitleMode: .never)
    }
}

#if DEBUG

import SwiftUI

struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(LandmarkDetail(landmark: landmarkData[0]))
            .edgesIgnoringSafeArea(.all)
    }
}

#endif
