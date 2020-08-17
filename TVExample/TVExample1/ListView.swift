//
//  ListView.swift
//  Teste1
//
//  Created by brennobemoura on 20/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation
import UIKit
import UICreator

class NumberView: UICView {
    @UICOutlet var numberLabel: UILabel!
    @UICOutlet var highlightedView: UIView!

    let number: Int

    func configure(with number: Int) {
        self.numberLabel.text = "\(number)"
    }

    init(number: Int) {
        self.number = number
    }
}

extension NumberView {
    var body: ViewCreator {
        UICSpacer { [unowned self] in
            UICZStack {
                UICSpacer(vertical: 15, horizontal: 30) {
                    UICHStack {
                        UICVStack {
                            UICLabel("Detalhe")
                                .vertical(hugging: .defaultHigh, compression: .required)
                                .font(.callout)
                                .textColor(.black)

                            UICLabel("Número: ")
                                .horizontal(hugging: .defaultHigh, compression: .required)
                                .font(.body(weight: .bold))
                                .textColor(.black)
                        }

                        UICLabel("\(self.number)")
                            .horizontal(compression: .required)
                            .font(.systemFont(ofSize: 18))
                            .textColor(.black)
                            .textAlignment(.right)
                            .as(self.$numberLabel)
                    }
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

    func viewDidLoad() {
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
        UICList(style: .plain) {
            UICHeader {
                UICZStack {
                    UICBlur(blur: .extraLight)
                    NumberView(number: 1).insets()
                }
            }

            UICForEach(self.$numbers) { number in
                UICRow {
                    NumberView(number: number)
                }
            }
        }
        .onInTheScene { _ in
            self.loop()
        }
        .row(height: UITableView.automaticDimension)
        .row(estimatedHeight: 44)
        .as(self.$tableView)
        .header(size: CGSize(width: 0, height: 60)) {
            UICSpacer(spacing: 5) {
                UICRounder(radius: 15) {
                    UICSpacer(spacing: 15) {
                        UICHStack {
                            UICDashed(color: .black) {
                                UICRounder(radius: 0.5) {
                                    UICImage(image: nil)
                                        .aspectRatio(priority: .required)
                                        .content(mode: .scaleAspectFill)
                                        .clipsToBounds(true)
                                }
                            }
                            UICLabel("Hello World!")
                                .font(.boldSystemFont(ofSize: 18))
                                .textColor(.white)
                                .navigation(title: "Lista Numérica")
                        }
                        .spacing(15)
                    }
                    .backgroundColor(.orange)
                    .onTap {
                        $0.backgroundColor = [UIColor]([.black, .orange])[Int.random(in: 0...1)]
                    }
                }
            }
        }.backgroundColor(.white)
            .safeArea(topEqualTo: 0)
            .background {
                UICZStack {
                    UICImage(image: nil)
                        .content(mode: .scaleAspectFill)
                        .clipsToBounds(true)
                        .insets()
                    UICBlur(blur: .extraLight)
                }
        }
    }
}

#if DEBUG && UICREATOR_SUIPREVIEWS
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
