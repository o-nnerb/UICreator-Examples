//
//  CircleImage.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

class CircleImage: UICView {
    let image: UIImage

    init(image: UIImage) {
        self.image = image
        super.init()
    }

    var body: ViewCreator {
        UICSpacer {
            UICCircle {
                UICImage(image: self.image)
                    .aspectRatio()
                    .content(mode: .scaleAspectFill)
            }.borderWidth(4)
            .borderColor(.white)
        }.shadowRadius(10)
        .shadowOcupacity(0.3)
    }
}

#if DEBUG

import SwiftUI

struct CircleImage_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(CircleImage(image: landmarkData[0].image))
    }
}

#endif
