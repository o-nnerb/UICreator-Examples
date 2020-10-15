//
//  ListView.swift
//  Teste1
//
//  Created by brennobemoura on 20/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import UICreator

class ListView: UICView {

    var body: ViewCreator {
        UICList(style: .plain) {
            UICHeader {
                UICZStack {
                    UICBlur(blur: .extraLight)
                    NumberView(1).insets()
                }
            }

            UICForEach(0 ..< 100) { number in
                UICRow {
                    NumberView(number)
                }
            }
        }
        .header {
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
                                .navigation(title: "Crazy Numeric List")
                        }
                        .spacing(15)
                    }
                    .backgroundColor(.orange)
                }
            }
        }
        .backgroundColor(.white)
        .insets()
    }
}
