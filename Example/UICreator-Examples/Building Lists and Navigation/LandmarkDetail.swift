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
        UICSpacer {
            UICVStack(
                MapView()
                    .leading()
                    .height(equalTo: 300),

                UICSpacer {
                    Child(
                        LandmarkImage(image: self.landmark.image)
                            .top(equalTo: -130)
                            .insets(.bottom, .leading, .trailing)
                            .height(equalTo: 260)
                    )
                },

                UICSpacer()
                    .height(equalTo: 15),

                UICVStack(
                    UICLabel(self.landmark.name)
                        .font(.title1),
                    UICHStack(
                        UICLabel(self.landmark.city)
                            .font(.subheadline),
                        UICSpacer(),
                        UICLabel(self.landmark.country)
                            .font(.subheadline)
                    )
                ).safeArea(leadingEqualTo: 15),

                UICSpacer()
            ).alignment(.center)
        }.safeArea(.top)
        .background(color: .white)
        .navigation(title: landmark.name)
        .navigation(largeTitleMode: .never)
    }
}

import SwiftUI

struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(LandmarkDetail(landmark: landmarkData[0]))
            .edgesIgnoringSafeArea(.all)
    }
}


