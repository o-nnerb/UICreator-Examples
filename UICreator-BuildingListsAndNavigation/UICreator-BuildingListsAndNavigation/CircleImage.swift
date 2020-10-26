//
//  CircleImage.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator
import UIKit

struct CircleImage: UICView {
    let image: UICImage

    init(_ image: UICImage) {
        self.image = image
    }

    var body: ViewCreator {
        UICSpacer {
            UICCircle {
                self.image
                    .aspectRatio()
                    .contentMode(.fill)
            }
            .borderWidth(4)
            .borderColor(.white)
        }
        .shadowRadius(10)
        .shadowOcupacity(0.3)
    }
}

#if DEBUG && UICREATOR_SUIPREVIEWS

import SwiftUI

struct CircleImage_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(CircleImage(image: landmarkData[0].image))
    }
}

#endif
