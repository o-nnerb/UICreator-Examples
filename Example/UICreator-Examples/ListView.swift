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

class NumberView: UICView, UIViewContext {
    weak var numberLabel: UILabel!
    weak var highlightedView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(with number: Int) {
        self.numberLabel.text = "\(number)"
    }

    init(number: Int) {
        super.init()
        self.context.number.value = number
    }

    class Context: UICreator.Context {
        let number: Value<Int?> = .init(value: nil)
    }

    func bindContext(_ context: Context) {
        context.number.sync { [weak self] in
            self?.numberLabel.text = "\($0 ?? 0)"
        }
    }
}

extension NumberView {
    var body: ViewCreator {
        Child(
            UICSpacer(vertical: 15, horizontal: 30) { [unowned self] in
                UICHStack(
                    UICVStack(
                        UICLabel("Detalhe")
                            .vertical(hugging: .defaultHigh, compression: .required)
                            .font(.callout)
                            .text(color: .black),
                        UICLabel("Número: ")
                            .horizontal(hugging: .defaultHigh, compression: .required)
                            .font(.body(weight: .bold))
                            .text(color: .black)
                    ),
                    UICLabel("1")
                        .horizontal(compression: .required)
                        .font(.systemFont(ofSize: 18))
                        .text(color: .black)
                        .text(alignment: .right)
                        .as(&self.numberLabel)
                        .toolbar(
                            UICSpacer()
                                .background(color: .black)
                                .insets(priority: .required)
                        ).toolbar(isHidden: false)
                        .toolbar(barTintColor: .black)
                        .toolbar(isTranslucent: false)
                )
            }.insets(),
            UICSpacer()
                .background(color: .black)
                .alpha(0)
                .as(&self.highlightedView)
        ).isUserInteractionEnabled(true)
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
            }.cancelWhenTouchMoves(true).cancelsTouches(inView: false)
        }
    }
}

class ListView: UICView {
    weak var tableView: UITableView!

    func newNumbers() -> [Int] {
        return (1...100).map {
            $0
        }
    }

    lazy var numbers: Value<[Int]> = {
        return .init(value: self.newNumbers())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }

    func loop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.numbers.value = self?.newNumbers() ?? []
            self?.loop()
        }
    }
}

extension ListView {
    var body: ViewCreator {
        UICList(style: .plain, .init(
            UICSection(
                UICRow {
                    UICSpacer()
                        .height(equalTo: 45)
                        .background(color: .black)
                }
            ),
            UICForEach(self.numbers) { number in
                UICSection(
                    UICHeader {
                        Child(
                            UICBlur(blur: .extraLight),
                            NumberView(number: number).insets()
                        )
                    },

                    UICRow {
                        NumberView(number: number)
                    }
                )
            }
        ))
        .row(height: UITableView.automaticDimension)
        .row(estimatedHeight: 44)
        .as(&self.tableView)
        .header(size: .init(width: 0, height: 60)) {
            UICSpacer(spacing: 5) {
                UICRounder(radius: 15) {
                    UICSpacer(spacing: 15) {
                        UICHStack(
                            UICDashed(color: .black) {
                                UICRounder(radius: 0.5) {
                                    UICImage(image: #imageLiteral(resourceName: "cristoredentor"))
                                        .aspectRatio(priority: .required)
                                        .content(mode: .scaleAspectFill)
                                        .clips(toBounds: true)
                                }
                            },
                            UICLabel("Hello World!")
                                .font(.boldSystemFont(ofSize: 18))
                                .text(color: .white)
                                .navigation(title: "Lista Numérica")
                        ).spacing(15)
                    }.background(color: .orange)
                        .onTap {
                            $0.backgroundColor = [UIColor]([.black, .orange])[Int.random(in: 0...1)]
                    }
                }
            }
        }.background(color: .white)
            .safeArea(topEqualTo: 0)
            .navigation(largeTitleMode: .always)
            .navigation(prefersLargeTitles: true)
            .background {
                Child(
                    UICImage(image: #imageLiteral(resourceName: "cristoredentor"))
                        .content(mode: .scaleAspectFill)
                        .clips(toBounds: true)
                        .insets(),
                    UICBlur(blur: .extraLight)
                )
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ListView_LivePreview: PreviewProvider {
    static var previews: some SwiftUI.View {
        LivePreview {
            Teste1.ContentView()
        }.previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}

#endif
