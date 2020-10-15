//
//  NumberView.swift
//  TVExample1
//
//  Created by brennobemoura on 15/10/20.
//  Copyright © 2020 brennobemoura. All rights reserved.
//

import UICreator
import UIKit

class NumberView: UICView {
    @Property(\.sizeCategory) var sizeCategory
    @UICOutlet var highlightedView: UIView!

    let number: Int

    init(_ number: Int) {
        self.number = number
    }

    var body: ViewCreator {
        UICSpacer { [unowned self] in
            UICZStack {
                UICSpacer(vertical: 15, horizontal: 30) {
                    UICHStack {
                        UICVStack {
                            UICLabel("Detail")
                                .vertical(hugging: .defaultHigh, compression: .required)
                                .font(.callout)
                                .textColor(.black)

                            UICLabel("Number: ")
                                .horizontal(hugging: .defaultHigh, compression: .required)
                                .font(.body(weight: .bold))
                                .textColor(.black)
                        }

                        UICLabel("\(self.number)")
                            .horizontal(compression: .required)
                            .font(.systemFont(ofSize: 18))
                            .textColor(.black)
                            .textAlignment(.right)
                    }
                    .axis(self.$sizeCategory.map { $0 >= .accessibilityMedium ? .vertical : .horizontal })
                }
                .insets()

                UICSpacer()
                    .backgroundColor(.black)
                    .alpha(0)
                    .as(self.$highlightedView)
            }
            .isUserInteractionEnabled(true)
            .onTouchMaker {
                $0.onBegan { touch in
                    self.animate(0.05) {_ in
                        self.highlightedView.alpha = 0.15
                    }
                }
                .onEnded { _ in
                    self.animate(0.075) {_ in
                        self.highlightedView.alpha = 0
                    }
                }
                .cancelsTouches(inView: false)
            }
            .dynamicProperty(self._sizeCategory)
        }
    }
}
