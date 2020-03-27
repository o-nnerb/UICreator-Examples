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

class ListView: UICView {
    @Value var removeRows: [IndexPath] = []
    @Value var addRows: [IndexPath] = []

    func newNumbers() -> [(Int, [Int])] {
        return (1...100).map {
            ($0, [$0])
        }
    }

    @Value var numbers: [(Int, [Int])] = (1...100).map {
        ($0, [$0])
    }

    func loop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.numbers = self?.newNumbers() ?? []
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
                                        .height(equalTo: 25)
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
            UICZStack {[
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
        UICZStack {[
            UICSpacer { [unowned self] in
                UICList(style: .plain) {[
                    UICForEach(self.$numbers) { section in
                        UICSection {[
                            UICHeader {
                                NumberView(number: section.0)
                            },

                            UICForEach(section.1) { number in
                                UICRow {
                                    NumberView(number: number)
                                }.trailingActions {[
                                    UICContextualAction("Delete", style: .destructive)
                                        .deleteAction(with: .left) {
                                            self.numbers.remove(at: $0.section)
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
                    ]}.deleteRows(with: .left, self.$removeRows) { [weak self] indexPaths in
                        indexPaths.forEach { _ in
                            self?.numbers.remove(at: 0)
                        }
                }.insertRows(with: .right, self.$addRows) { [weak self] indexPaths in
                    indexPaths.forEach {
                        self?.numbers[$0.section].1.append($0.row)
                    }
                }
                .row(height: UITableView.automaticDimension)
                .row(estimatedHeight: 44)
                .header {
                    Header()
                }.background(color: .white)
                    .background {
                    Background()
                }
            }
            .safeArea(topEqualTo: 0)
            .insets(.leading, .trailing, .bottom)
        ]}
        .navigation(largeTitleMode: .always)
        .navigation(prefersLargeTitles: true)
        .navigation(leftButton: { [weak self] in
            UICButton("Delete")
                .title(color: .black)
                .onTap { _ in
                    self?.removeRows = (0..<10).map {
                        IndexPath(row: 0, section: $0)
                    }
                }
        })
        .navigation(rightButton: { [weak self] in
            UICButton("Add")
                .title(color: .black)
                .onTap { _ in
                    self?.addRows = (0..<10).map {
                        IndexPath(row: self?.numbers[$0].1.count ?? 0, section: $0)
                    }
            }
        })
    }
}

//#if DEBUG && canImport(SwiftUI)
//import SwiftUI
//
//@available(iOS 13, *)
//struct ListView_LivePreview: PreviewProvider {
//    static var previews: some SwiftUI.View {
//        LivePreview {
//            ContentView()
//        }.previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//    }
//}
//
//#endif
