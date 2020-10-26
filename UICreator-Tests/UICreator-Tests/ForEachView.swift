//
//  ForEachView.swift
//  Teste1
//
//  Created by brennobemoura on 13/01/20.
//  Copyright © 2020 brennobemoura. All rights reserved.
//

import Foundation
import UICreator

struct ForEachView: UICView {
    @Value var array: [Int] = []

    func updateEvery1Seconds() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if Bool.random() {
                self.array.append(Int.random(in: 0..<1000))
            } else {
                if !self.array.isEmpty {
                    self.array.removeFirst()
                }
            }
            
            self.updateEvery1Seconds()
        }
    }

    var body: ViewCreator {
        UICVScroll {
            UICVStack {
                UICForEach(self.$array) {
                    NumberView(number: $0)
                }
            }
        }
        .onInTheScene { _ in
            self.updateEvery1Seconds()
        }
    }
}
