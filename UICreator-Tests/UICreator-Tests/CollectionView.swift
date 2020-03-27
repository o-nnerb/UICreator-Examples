//
//  CollectionView.swift
//  Teste1
//
//  Created by brennobemoura on 22/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation
import UIKit
import UIContainer
import UICreator

class MyLabel: UICViewRepresentable, TextElement {
    typealias View = UILabel

    required init(_ text: String?) {
        self.onNotRendered {
            ($0 as? View)?.text = text
        }
    }

    required init(_ attributedText: NSAttributedString?) {
        self.onNotRendered {
            ($0 as? View)?.attributedText = attributedText
        }
    }

    func makeUIView() -> View {
        return .init()
    }

    func updateView(_ view: UILabel) {}
}

class BackgroundView: Root {
    let randomNumber: Int

    var color: UIColor {
        UIColor(red: {
            CGFloat(randomNumber % 255) / 255
        }(), green: {
            CGFloat(Int(CGFloat(randomNumber) / 255) % 255) / 255
        }(), blue: {
            CGFloat(Int((CGFloat(randomNumber) / 255) / 255) % 255) / 255
        }(), alpha: 1)
    }

    init(_ randomNumber: Int) {
        self.randomNumber = randomNumber
    }
}

extension BackgroundView: TemplateView {
    var body: ViewCreator {
        UICSpacer()
            .background(color: self.color)
    }
}

class CollectionView: Root {
    weak var pageControl: UIPageControl!

    lazy var numbers: [Int] = {
        (0...100).compactMap { _ in
            (Int(0)...Int(pow(255.0, 3))).randomElement()
        }
    }()
}

extension CollectionView: TemplateView {
    private var thirdGroup: UICCollectionLayoutGroup {
        UICCollectionLayoutGroup {[
            UICCollectionLayoutGroup(horizontal: .flexible(1/3)) {[
                UICCollectionLayoutItem(vertical: .equalTo(60), numberOfElements: 3)
            ]},
            UICCollectionLayoutItem(vertical: .flexible(1), horizontal: .flexible(2/3))
        ]}
    }

    var body: ViewCreator {
        UICFlow {[
            UICSection {[
                UICHeader {
                    UICLabel("This is a example of auto layout header")
                        .vertical(hugging: .required, compression: .required)
                },

                UICForEach(Array(self.numbers.enumerated())) { number in
                    UICRow {
                        BackgroundView(number.element)
                            .aspectRatio()
                    }
                }
            ]}
        ]}.layoutMaker {[
            UICCollectionLayoutSection {[
                UICCollectionLayoutHeader(vertical: .estimated(150)),

                UICCollectionLayoutGroup(horizontal: .flexible(1)) {[
                    UICCollectionLayoutItem(horizontal: .flexible(1/4))
                ]}
            ]}
        ]}
        .line(minimumSpacing: 0)
        .interItem(minimumSpacing: 0)
        .scroll(direction: .vertical)
        .background(color: .clear)
        .background {
            UICZStack {[
                UICImage(image: #imageLiteral(resourceName: "waterfall"))
                    .content(mode: .scaleAspectFill)
                    .clips(toBounds: true)
                    .insets(),
                UICBlur(blur: .extraLight),
                UICSpacer()
                    .background(color: .white)
                    .safeArea(topEqualTo: 0)
            ]}
        }
    }
}
