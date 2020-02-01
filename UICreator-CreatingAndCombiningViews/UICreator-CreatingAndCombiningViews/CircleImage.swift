//
//  TurtleRock.CircleImage.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

class CircleImage: UICView {
    var body: ViewCreator {
        UICSpacer {
            UICCircle {
                UICImage(image: .init(imageLiteralResourceName: "cristoredentor"))
                    .aspectRatio()
                    .content(mode: .scaleAspectFill)
            }.border(width: 4)
            .border(color: .white)
        }.shadow(radius: 10)
        .shadow(ocupacity: 0.3)
    }
}

#if DEBUG
import SwiftUI

struct CircleImage_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(CircleImage())
    }
}
#endif
