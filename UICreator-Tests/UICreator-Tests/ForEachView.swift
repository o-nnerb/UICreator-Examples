//
//  ForEachView.swift
//  Teste1
//
//  Created by brennobemoura on 13/01/20.
//  Copyright © 2020 brennobemoura. All rights reserved.
//

import Foundation
import UICreator

class ForEachView: UICView {
    @Value var array: [Int] = []

    func updateEvery1Seconds() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            if Bool.random() {
                self?.array.append(Int.random(in: 0..<1000))
            } else {
                if !(self?.array.isEmpty ?? true) {
                    self?.array.removeFirst()
                }
            }
            
            self?.updateEvery1Seconds()
        }
    }

    var body: ViewCreator {
        UICVScroll { [unowned self] in
            UICVStack {
                UICForEach(self.$array) {
                    NumberView(number: $0)
                }
            }
        }
        .onInTheScene { [weak self] _ in
            self?.updateEvery1Seconds()
        }
    }
}
