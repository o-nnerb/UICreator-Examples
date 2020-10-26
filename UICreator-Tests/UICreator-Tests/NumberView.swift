//
//  NumberView.swift
//  UICreator-Tests
//
//  Created by brennobemoura on 26/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import UICreator

struct NumberView: UICView {
    @Property(\.sizeCategory) var sizeCategory
    @UICOutlet var highlightedView: UIView!
    @Value var number: String? = nil
    @Value var alpha: CGFloat = .zero

    init(number: Int) {
        self.number = "\(number)"
    }

    var body: ViewCreator {
        UICSpacer {
            UICZStack {
                UICSpacer(vertical: 15, horizontal: 30) {
                    UICStack(axis: self.$sizeCategory.map { $0 >= .accessibilityMedium ? .vertical : .horizontal }) {
                        UICVStack {
                            MyLabel("Detalhe")
                                .vertical(hugging: .defaultHigh, compression: .required)
                                .font(.callout)
                                .textColor(.black)
                            
                            UICLabel("Número: ")
                                .horizontal(hugging: .defaultHigh, compression: .required)
                                .font(.body(weight: .bold))
                                .textColor(.black)
                        }

                        UICSpacer()
                            .isHidden(self.$sizeCategory.map { $0 >= .accessibilityMedium })

                        UICLabel(self.$number)
                            .horizontal(compression: .required)
                            .font(.body)
                            .textColor(.black)
                    }
                }
                .insets()
                
                UICSpacer()
                    .backgroundColor(.black)
                    .alpha(self.$alpha)
                    .as(self.$highlightedView)
            }
        }
        .isUserInteractionEnabled(true)
        .isExclusiveTouch(false)
        .onTouchMaker {
            Touch()
                .cancelWhenTouchMoves(true)
                .cancelsTouches(inView: false)
                .onBegan { touch in
                    UIView.animate(withDuration: 0.05) {
                        self.alpha = 0.15
                    }
                }
                .onEnded { _ in
                    UIView.animate(withDuration: 0.075) {
                        self.alpha = 0
                    }
                }
        }
        .dynamicProperty(self._sizeCategory)
    }
}
