//
//  ListView.swift
//  Teste1
//
//  Created by brennobemoura on 20/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation
import UIKit
import UIContainer
import UICreator

class NumberView: UICView {
    @UICOutlet var numberLabel: UILabel!
    @UICOutlet var highlightedView: UIView!

    let number: Int

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(with number: Int) {
        self.numberLabel.text = "\(number)"
    }

    init(number: Int) {
        self.number = number
    }
}

extension NumberView {
    var body: ViewCreator {
        UICZStack {[
            UICSpacer(vertical: 15, horizontal: 30) { [unowned self] in
                UICHStack {[
                    UICVStack {[
                        UICLabel("Detalhe")
                            .vertical(hugging: .defaultHigh, compression: .required)
                            .font(.callout)
                            .text(color: .black),
                        UICLabel("Número: ")
                            .horizontal(hugging: .defaultHigh, compression: .required)
                            .font(.body(weight: .bold))
                            .text(color: .black)
                    ]},
                    UICLabel("\(self.number)")
                        .horizontal(compression: .required)
                        .font(.systemFont(ofSize: 18))
                        .text(color: .black)
                        .text(alignment: .right)
                        .as(self.$numberLabel)
//                        .toolbar(
//                            UICSpacer()
//                                .background(color: .black)
//                                .insets(priority: .required)
//                        ).toolbar(isHidden: false)
//                        .toolbar(barTintColor: .black)
//                        .toolbar(isTranslucent: false)
                ]}
            }.insets(),
            UICSpacer()
                .background(color: .black)
                .alpha(0)
                .as(self.$highlightedView)
        ]}.isUserInteractionEnabled(true)
//        .isExclusiveTouch(false)
        .onTouchMaker {
            $0.onBegan { touch in
                self.animate(0.05) {_ in
                    self.highlightedView.alpha = 0.15
                }
            }.onEnded { _ in
                self.animate(0.075) {_ in
                    self.highlightedView.alpha = 0
                }
            }.cancelsTouches(inView: false)
//            .cancelWhenTouchMoves(true)
//                .cancelsTouches(inView: false)
        }
    }
}

//extension NumberView {
//    class Cell: ContainerTableViewCell<NumberView> {
//        override func containerDidLoad() {
//            super.containerDidLoad()
//            self.selectionStyle = .none
//            self.backgroundColor = .white
//        }
//    }
//}

class ListView: UICView {
    @UICOutlet var tableView: UITableView!

    func newNumbers() -> [Int] {
        return (1...100).map {
            $0
        }
    }

    @Value var numbers: [Int] = (1...100).map {
        $0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }

    func loop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.numbers = self?.newNumbers() ?? []
            self?.loop()
        }
    }
}

extension ListView {
    var body: ViewCreator {
        UICList(style: .plain) {[
            UICHeader {
                UICZStack {[
                    UICBlur(blur: .extraLight),
                    NumberView(number: 1).insets()
                ]}
            },
            UICForEach(self.$numbers) { number in
                UICRow {
                    NumberView(number: number)
                }
            }
        ]}
        .onInTheScene { _ in
            self.loop()
        }
        .row(height: UITableView.automaticDimension)
        .row(estimatedHeight: 44)
        .as(self.$tableView)
        .header(size: .init(width: 0, height: 60)) {
            UICSpacer(spacing: 5) {
                UICRounder(radius: 15) {
                    UICSpacer(spacing: 15) {
                        UICHStack {[
                            UICDashed(color: .black) {
                                UICRounder(radius: 0.5) {
                                    UICImage(image: nil)
                                        .aspectRatio(priority: .required)
                                        .content(mode: .scaleAspectFill)
                                        .clips(toBounds: true)
                                }
                            },
                            UICLabel("Hello World!")
                                .font(.boldSystemFont(ofSize: 18))
                                .text(color: .white)
                                .navigation(title: "Lista Numérica")
                        ]}.spacing(15)
                    }.background(color: .orange)
                        .onTap {
                            $0.backgroundColor = [UIColor]([.black, .orange])[Int.random(in: 0...1)]
                    }
                }
            }
        }.background(color: .white)
            .safeArea(topEqualTo: 0)
//            .navigation(largeTitleMode: .always)
//            .navigation(prefersLargeTitles: true)
            .background {
                UICZStack {[
                    UICImage(image: nil)
                        .content(mode: .scaleAspectFill)
                        .clips(toBounds: true)
                        .insets(),
                    UICBlur(blur: .extraLight)
                ]}
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ListView_LivePreview: PreviewProvider {
    static var previews: some SwiftUI.View {
        LivePreview {
            TVExample1.ContentView()
        }.previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}

#endif
