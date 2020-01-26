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
        Child { [unowned self] in [
            UICSpacer(vertical: 15, horizontal: 30) {
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
                    UICLabel("1")
                        .horizontal(compression: .required)
                        .font(.systemFont(ofSize: 18))
                        .text(color: .black)
                        .text(alignment: .right)
                        .as(&self.numberLabel)
                        .toolbar {[
                            UICSpacer()
                                .background(color: .black)
                                .insets(priority: .required)
                        ]}.toolbar(isHidden: false)
                        .toolbar(barTintColor: .black)
                        .toolbar(isTranslucent: false)
                ]}
            }.insets(),
            UICSpacer()
                .background(color: .black)
                .alpha(0)
                .as(&self.highlightedView)
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
            }.cancelWhenTouchMoves(true).cancelsTouches(inView: false)
        }
    }
}

class ListView: UICView {
    weak var tableView: UITableView!
    let removeRows: Value<[IndexPath]> = .init(value: [])
    let addRows: Value<[IndexPath]> = .init(value: [])

    func newNumbers() -> [(Int, [Int])] {
        return (1...100).map {
            ($0, [$0])
        }
    }

    lazy var numbers: Value<[(Int, [Int])]> = {
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
    class Header: UICView {
        var body: ViewCreator {
            UICSpacer(spacing: 5) {
                UICRounder(radius: 15) {
                    UICSpacer(spacing: 15) {
                        UICHStack(spacing: 15) {[
                            UICDashed(color: .black) {
                                UICRounder(radius: 0.5) {
                                    UICImage(image: #imageLiteral(resourceName: "waterfall"))
                                        .aspectRatio(priority: .required)
                                        .content(mode: .scaleAspectFill)
                                        .clips(toBounds: true)
                                }
                            },
                            UICLabel("Hello World!")
                                .font(.boldSystemFont(ofSize: 18))
                                .text(color: .white)
                                .navigation(title: "Lista Numérica")
                        ]}
                    }.background(color: .orange)
                        .onTap {
                            $0.backgroundColor = [UIColor]([.black, .orange])[Int.random(in: 0...1)]
                    }
                }
            }
        }
    }

    class Background: UICView {
        var body: ViewCreator {
            Child {[
                UICImage(image: #imageLiteral(resourceName: "waterfall"))
                    .content(mode: .scaleAspectFill)
                    .clips(toBounds: true)
                    .insets(),
                UICBlur(blur: .extraLight)
            ]}
        }
    }
}

extension ListView {
    var body: ViewCreator {
        UICSpacer { [unowned self] in
            UICList(style: .plain) {[
                UICSection {[
                    UICRow {
                        UICSpacer()
                            .height(equalTo: 45)
                            .background(color: .black)
                    }
                ]},

                UICForEach(self.numbers) { number in
                    UICSection {[
                        UICHeader {
                            Child {[
                                UICBlur(blur: .extraLight),
                                NumberView(number: number.0).insets()
                            ]}
                        },

                        UICForEach(number.1) { number in
                            UICRow {
                                NumberView(number: number)
                            }.trailingActions {[
                                UICContextualAction("Delete", style: .destructive)
                                    .deleteAction(with: .left) {
                                        self.numbers.value.remove(at: $0.section - 1)
                                },
                                UICContextualAction("Edit", style: .normal)
                                    .onAction { _ in
                                        print("edit")
                                        return true
                                    }
                            ]}
                        }
                    ]}
                }
            ]}.deleteRows(with: .left, self.removeRows) { [weak self] indexPaths in
                indexPaths.forEach {
                    self?.numbers.value[$0.section].1.removeFirst()
                }
            }.insertRows(with: .right, self.addRows) { [weak self] indexPaths in
                indexPaths.forEach {
                    self?.numbers.value[$0.section].1.append($0.section)
                }
            }
            .row(height: UITableView.automaticDimension)
            .row(estimatedHeight: 44)
            .as(&self.tableView)
            .header(size: .init(width: 0, height: 60)) {
                Header()
            }.background(color: .white)
            .background {
                Background()
            }
        }
        .safeArea(topEqualTo: 0)
        .navigation(largeTitleMode: .always)
        .navigation(prefersLargeTitles: true)
        .navigation(leftButton: { [weak self] in
            UICButton("Delete")
                .title(color: .black)
                .onTap { _ in
                    self?.removeRows.value = (0..<10).map {
                        IndexPath(row: 0, section: $0+1)
                    }
                }
        })
        .navigation(rightButton: { [weak self] in
            UICButton("Add")
                .title(color: .black)
                .onTap { _ in
                    self?.addRows.value = (0..<10).map {
                        IndexPath(row: 0, section: $0+1)
                    }
            }
        })
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ListView_LivePreview: PreviewProvider {
    static var previews: some SwiftUI.View {
        LivePreview {
            ContentView()
        }.previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}

#endif
