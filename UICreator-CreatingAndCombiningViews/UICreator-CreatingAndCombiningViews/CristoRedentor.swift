//
//  UserView.swift
//  UICreator-Examples_Example
//
//  Created by brennobemoura on 21/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UICreator
import UIKit

class CristoRedentor: UICView {
    @Property(\.sizeCategory) var sizeCategory

    var body: ViewCreator {
        UICVStack {
            MapView()
                .leading()
                .height(equalTo: 300)
            
            UICZStack {
                UICCenter {
                    CircleImage()
                        .bottom()
                }
                .top(equalTo: -130)
            }

            UICSpacer()
                .height(equalTo: 15)
            
            UICVStack {
                UICLabel("Cristo Redentor")
                    .font(.title1)
                
                UICHStack {
                    UICLabel("Rio de Janeiro")
                        .font(.subheadline)
                    
                    UICSpacer()
                        .isHidden(self.$sizeCategory.map { $0 >= .accessibilityMedium })
                    
                    UICLabel("Brasil")
                        .font(.subheadline)
                }
                .axis(self.$sizeCategory.map { $0 >= .accessibilityMedium ? .vertical : .horizontal })
            }
            .safeArea(leadingEqualTo: 15)
            
            UICSpacer()
        }
        .alignment(.center)
        .dynamicProperty(self._sizeCategory)
    }
}

#if DEBUG && UICREATOR_SUIPREVIEWS
import SwiftUI

struct CristoRedentor_Preview: PreviewProvider {
    static var previews: some View {
        LivePreview(CristoRedentor())
            .edgesIgnoringSafeArea(.all)
    }
}

#endif

