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

class NumberView: UICView {
    @Property(\.sizeCategory) var sizeCategory
    @UICOutlet var highlightedView: UIView!
    @Value var number: String? = nil

    init(number: Int) {
        self.number = "\(number)"
    }

    var body: ViewCreator {
        UICSpacer { [unowned self] in
            UICZStack {
                UICSpacer(vertical: 15, horizontal: 30) {
                    UICHStack {
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
                    .axis(self.$sizeCategory.map { $0 >= .accessibilityMedium ? .vertical : .horizontal })
                }
                .insets()
                
                UICSpacer()
                    .backgroundColor(.black)
                    .alpha(0)
                    .as(self.$highlightedView)
            }
        }
        .isUserInteractionEnabled(true)
        .isExclusiveTouch(false)
        .onTouchMaker {
            $0.onBegan { touch in
                self.animate(0.05) {_ in
                    self.highlightedView.alpha = 0.15
                }
            }.onEnded { _ in
                self.animate(0.075) {_ in
                    self.highlightedView.alpha = 0
                }
            }
            .cancelWhenTouchMoves(true)
            .cancelsTouches(inView: false)
        }
        .dynamicProperty(self._sizeCategory)
    }
}
