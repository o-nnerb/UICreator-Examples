//
//  TabView.swift
//  UICreator-Tests
//
//  Created by brennobemoura on 27/10/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UICreator

struct TabView: UICView {
    @Value var selectedItem: Int = .zero
    @Value var isAjustedHidden: Bool = false
    
    var body: ViewCreator {
        UICTab(selectedItem: self.$selectedItem) {
            UICTabItem("Home") {
                BackgroundView(30419)
            }

            UICTabItem("Ajustes") {
                BackgroundView(1293789)
                    .isHidden(self.$isAjustedHidden)
                    .onTap { _ in
                        selectedItem = .zero
                        isAjustedHidden = true
                    }
            }
        }
    }
}
