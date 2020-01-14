//
//  PagedView.swift
//  Teste1
//
//  Created by brennobemoura on 03/01/20.
//  Copyright © 2020 brennobemoura. All rights reserved.
//

import Foundation
import UIKit
import UICreator

class PagedView: Root {
    weak var pageView: UIPageControl!
    weak var pageViewController: PageViewController!

}

extension PagedView: TemplateView {
    func moveToPage(_ page: Int) {
        self.pageView.currentPage = page
        self.pageViewController.currentPage = page
    }
    var body: ViewCreator {
        Pages(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            .pages(direction: .reverse, .init(
                BackgroundView(254333),
                BackgroundView(10254333),
                Child(
                    BackgroundView(50254333),
                    Top {
                        Button("Tap here!")
                            .onTouchInside {
                                $0.window?.rootViewController = .init()
                            }
                    }.safeAreaInsets()
                )
//                BackgroundView()
            )).addIndicator(atLocation: .bottom) {
                Spacer(top: 0, bottom: 15, leading: 15, trailing: 15) {
                    VStack(
                        Page(numberOfPages: 3)
                            .as(&self.pageView)
                            .onPageChanged { _ in
                                if self.pageView.currentPage != self.pageViewController.currentPage {
                                    self.pageViewController.currentPage = self.pageView.currentPage
                                }
                            },
                        Rounder(radius: 30) {
                            Child(
                                Blur(blur: .dark),
                                Spacer(vertical: 15, horizontal: 30) {
                                    HStack(spacing: 15, .init(
                                        Center {
                                            Spacer {
                                                Rounder(radius: 15) {
                                                    BackgroundView(254333)
                                                }.onTap { _ in
                                                    self.moveToPage(0)
                                                }
                                            }.aspectRatio()
                                            .top()
                                            .bottom()
                                        },
                                        Center {
                                            Spacer {
                                                Rounder(radius: 15) {
                                                    BackgroundView(10254333)
                                                }.onTap { _ in
                                                    self.moveToPage(1)
                                                }
                                            }.aspectRatio()
                                            .top()
                                            .bottom()
                                        },
                                        Center {
                                            Spacer {
                                                Rounder(radius: 15) {
                                                    BackgroundView(50254333)
                                                }.onTap { _ in
                                                    self.moveToPage(2)
                                                }
                                            }.aspectRatio()
                                            .top()
                                            .bottom()
                                        }
                                    )).distribution(.fillEqually)
                                    .height(equalTo: 70)
                                }.insets()
                            )
                        }
                    )
                }.insets()
            }.insets()
            .as(&self.pageViewController)
            .onPageChanged {
                self.pageView.currentPage = $0
            }
    }
}
