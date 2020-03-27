//
//  NumberView.swift
//  UICreator-Tests
//
//  Created by brennobemoura on 26/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import UIContainer
import UICreator

class NumberView: UICView {
    @UICOutlet var highlightedView: UIView!
    @Value var number: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(number: Int) {
        super.init()
        self.number = "\(number)"
    }
}

extension NumberView {
    var body: ViewCreator {
        UICZStack { [unowned self] in [
            UICSpacer(vertical: 15, horizontal: 30) {
                UICHStack {[
                    UICVStack {[
                        MyLabel("Detalhe")
                            .vertical(hugging: .defaultHigh, compression: .required)
                            .font(.callout)
                            .text(color: .black),
                        UICLabel("Número: ")
                            .horizontal(hugging: .defaultHigh, compression: .required)
                            .font(.body(weight: .bold))
                            .text(color: .black)
                    ]},
                    UICLabel(self.$number)
                        .horizontal(compression: .required)
                        .font(.systemFont(ofSize: 18))
                        .text(color: .black)
                        .text(alignment: .right)
                ]}
            }.insets(),
            UICSpacer()
                .background(color: .black)
                .alpha(0)
                .as(self.$highlightedView)
        ]}.isUserInteractionEnabled(true)
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
    }
}
