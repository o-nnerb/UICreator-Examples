//
//  LandmarkRow.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator
class LandmarkRow: UICView {
    let landmark: Landmark
    init(landmark: Landmark) {
        self.landmark = landmark
    }

    var body: ViewCreator {
        UICSpacer(vertical: 5) { [unowned self] in
            UICHStack {[
                UICImage(image: self.landmark.image)
                    .aspectRatio()
                    .height(equalTo: 50)
                    .content(mode: .scaleAspectFill)
                    .clipsToBounds(true),
                UICLabel(self.landmark.name),
                UICSpacer()
            ]}.spacing(15)
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
