//
//  TurtleRock.CircleImage.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator
import UIKit

class CircleImage: UICView {
    var body: ViewCreator {
        UICSpacer {
            UICCircle {
                UICImage(image: UIImage(named: "cristoredentor"))
                    .aspectRatio()
                    .content(mode: .scaleAspectFill)
            }.borderWidth(4)
            .borderColor(.white)
        }.shadowRadius(10)
        .shadowOcupacity(0.3)
    }
}

#if DEBUG && UICREATOR_SUIPREVIEWS
import SwiftUI

struct CircleImage_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(CircleImage())
    }
}
#endif
