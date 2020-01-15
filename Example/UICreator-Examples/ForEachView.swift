//
//  ForEachView.swift
//  Teste1
//
//  Created by brennobemoura on 13/01/20.
//  Copyright © 2020 brennobemoura. All rights reserved.
//

import Foundation
import UICreator
import UIContainer

class ForEachView: Root {
    let array: Value<[Int]> = .init(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateEvery1Seconds()
    }

    func updateEvery1Seconds() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.array.value.append(Int.random(in: 0..<1000))

            self.updateEvery1Seconds()
        }
    }
}

extension ForEachView: TemplateView {
    var body: ViewCreator {
        VScroll {
            VStack(
                ForEach(self.array) {
                    Label("\($0)")
                        .vertical(hugging: .required, compression: .required)
                }
            )
        }
    }
}
