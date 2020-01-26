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
        self.uiView.text = text
    }

    required init(_ attributedText: NSAttributedString?) {
        self.uiView.attributedText = attributedText
    }

    func makeUIView() -> View {
        return .init()
    }

    func updateView(_ view: UILabel) {}
}

class BackgroundView: Root {
    weak var backgrounView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(with number: Int) {
        self.backgrounView.backgroundColor = UIColor(red: {
            CGFloat(number % 255) / 255
        }(), green: {
            CGFloat(Int(CGFloat(number) / 255) % 255) / 255
        }(), blue: {
            CGFloat(Int((CGFloat(number) / 255) / 255) % 255) / 255
        }(), alpha: 1)
    }

    convenience init(_ number: Int) {
        self.init()
        self.onNotRendered { _ in
            self.configure(with: number)
        }
    }
}

extension BackgroundView: TemplateView {
    var body: ViewCreator {
        UICSpacer()
            .as(&self.backgrounView)
    }
}

class CollectionView: Root {
    weak var collectionView: UICollectionView!
    weak var pageControl: UIPageControl!

    lazy var numbers: [Int] = {
        (0...100).compactMap { _ in
            (Int(0)...Int(pow(255.0, 3))).randomElement()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
    }
}

extension CollectionView: TemplateView {
    private var firstGroup: CollectionLayoutElement {
        .group(vertical: .equalTo(60)) {
            .items(horizontal: .flexible(1/2), quantity: 2)
        }
    }

    private var secondGroup: CollectionLayoutElement {
        .group(vertical: .equalTo(120)) {
            .items(horizontal: .flexible(1/2), quantity: 2)
        }
    }

    private var thirdGroup: CollectionLayoutElement {
        let first3items: CollectionLayoutElement = .group(horizontal: .flexible(1/3)) {
            .items(vertical: .equalTo(60), quantity: 3)
        }

        return .group(vertical: .equalTo(60 * 3)) {
            .sequence {[
                first3items,
                .item(vertical: .flexible(1), horizontal: .flexible(2/3))
            ]}
        }
    }

    var body: ViewCreator {
        UICVStack {[
            UICPageControl(numberOfPages: 2)
                .background(color: .black)
                .onPageChanged {
                    print(($0 as? UIPageControl)?.currentPage ?? "0")
                }.as(&self.pageControl),
            UICFlow {[
                BackgroundView()
            ]}.layoutMaker {
                .section {
                    .sequence {[
                        self.firstGroup,
                        self.secondGroup
                    ]}
                }
            }
            .line(minimumSpacing: 0)
            .interItem(minimumSpacing: 0)
            .dynamicDataSource(self)
            .as(&self.collectionView)
            .background(color: .clear)
            .scroll(direction: .vertical)
            .background {
                Child {[
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
        ]}.safeAreaInsets()
    }
}

extension CollectionView: CollectionDataSource {
    func numberOfRows(in section: Int, estimatedRows: Int) -> Int {
        return self.numbers.count
    }

    func cell(at indexPath: IndexPath, content: ViewCreator) {
        (content as? BackgroundView)?.configure(with: self.numbers[indexPath.row])
    }
}
