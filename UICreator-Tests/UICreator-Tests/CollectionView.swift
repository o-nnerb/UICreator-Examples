//
//  CollectionView.swift
//  Teste1
//
//  Created by brennobemoura on 22/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation
import UIKit
import UICreator

struct MyLabel: UICViewRepresentable {
    typealias View = UILabel

    private enum Content {
        case string(String?)
        case attributedText(NSAttributedString?)
    }

    @Relay private var content: Content

    init(_ text: String?) {
        self._content = .constant(.string(text))
    }

    init(_ text: Relay<String?>) {
        self._content = text.map { .string($0) }
    }


    init(_ attributedText: NSAttributedString?) {
        self._content = .constant(.attributedText(attributedText))
    }

    init(_ attributedText: Relay<NSAttributedString?>) {
        self._content = attributedText.map { .attributedText($0) }
    }

    func makeUIView() -> View {
        View()
    }

    func updateUIView(_ view: UILabel) {
        self.$content.sync { [weak view] in
            switch $0 {
            case .string(let string):
                view?.text = string
            case .attributedText(let attributedText):
                view?.attributedText = attributedText
            }
        }
    }
}

struct BackgroundView: UICView {
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

    var body: ViewCreator {
        UICSpacer()
            .backgroundColor(self.color)
    }
}

struct CollectionView: UICView {
    
    let numbers: [Int] = {
        (0...100).compactMap { _ in
            (Int(0)...Int(pow(255.0, 3))).randomElement()
        }
    }()

    private var thirdGroup: UICCollectionLayoutGroup {
        UICCollectionLayoutGroup {
            UICCollectionLayoutGroup(horizontal: .flexible(1/3)) {
                UICCollectionLayoutItem(vertical: .equalTo(60), numberOfElements: 3)
            }

            UICCollectionLayoutItem(vertical: .flexible(1), horizontal: .flexible(2/3))
        }
    }

    var body: ViewCreator {
        UICFlow {
            UICSection {
                UICHeader {
                    UICLabel("This is a example of auto layout header")
                        .vertical(hugging: .required, compression: .required)
                        .insets()
                }

                UICForEach(Array(self.numbers.enumerated())) { number in
                    UICRow {
                        BackgroundView(number.element)
                            .aspectRatio()
                    }
                }
            }
        }
        .layoutMaker {
            UICCollectionLayoutSection {
                UICCollectionLayoutHeader(vertical: .estimated(150))

                UICCollectionLayoutGroup(horizontal: .flexible(1)) {
                    UICCollectionLayoutItem(horizontal: .flexible(1/4))
                }
            }
        }
        .line(minimumSpacing: 0)
        .interItem(minimumSpacing: 0)
        .scroll(direction: .vertical)
        .backgroundColor(.clear)
        .background {
            UICZStack {
                UICImage(uiImage: #imageLiteral(resourceName: "waterfall"))
                    .contentMode(.fill)
                    .clipsToBounds(true)
                    .insets()

                UICBlur(.extraLight)

                UICSpacer()
                    .backgroundColor(.white)
                    .safeArea(topEqualTo: 0)
            }
        }
    }
}
