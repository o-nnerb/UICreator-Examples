//
//  ContentView.swift
//  UICreator-Tests
//
//  Created by brennobemoura on 23/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UICreator
import UIContainer

class ContentView: Root, TemplateView, ViewControllerType {
    var body: ViewCreator {
        UICSpacer {
            UICNavigation {
                MyLabel("Olá")
            }
        }.background(color: .white)
            .onAppear {
                print("[Appeared]", $0)
        }
    }
}
