//
//  UserView.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator

class CristoRedentor: UICView {
    var body: ViewCreator {
        UICVStack {[
            MapView()
                .leading()
                .height(equalTo: 300),

            UICZStack {[
                UICCenter {
                    CircleImage()
                        .bottom()
                }.top(equalTo: -130)
            ]},

            UICSpacer()
                .height(equalTo: 15),
            
            UICVStack {[
                UICLabel("Cristo Redentor")
                    .font(.title1),
                UICHStack {[
                    UICLabel("Rio de Janeiro")
                        .font(.subheadline),
                    UICSpacer(),
                    UICLabel("Brasil")
                        .font(.subheadline)
                ]}
            ]}.safeArea(leadingEqualTo: 15),

            UICSpacer()
        ]}.insets().alignment(.center)
    }
}

#if DEBUG
import SwiftUI

struct CristoRedentor_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(CristoRedentor())
            .edgesIgnoringSafeArea(.all)
    }
}

#endif

