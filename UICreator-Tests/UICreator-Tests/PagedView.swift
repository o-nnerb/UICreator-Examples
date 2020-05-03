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

class PagedView: UICView {
    @UICOutlet var pageView: UIPageControl!
    @UICOutlet var pageViewController: UICPageViewController!

    func moveToPage(_ page: Int) {
        self.pageView.currentPage = page
        self.pageViewController.currentPage = page
    }
    
    var body: ViewCreator {
        UICPage(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            .pages(direction: .reverse) {[
                BackgroundView(254333),
                BackgroundView(10254333),
                UICZStack {[
                    BackgroundView(50254333),
                    UICTop {
                        UICButton("Tap here!")
                            .onTouchInside {
                                $0.window?.rootViewController = .init()
                            }
                    }.safeAreaInsets()
                ]}
//                BackgroundView()
            ]}.addIndicator(atLocation: .bottom) { [unowned self] in
                UICSpacer(top: 0, bottom: 15, leading: 15, trailing: 15) {
                    UICVStack {[
                        UICPageControl(numberOfPages: 3)
                            .as(self.$pageView)
                            .onPageChanged { _ in
                                if self.pageView.currentPage != self.pageViewController.currentPage {
                                    self.pageViewController.currentPage = self.pageView.currentPage
                                }
                            },
                        UICRounder(radius: 30) {
                            UICZStack {[
                                UICBlur(blur: .dark),
                                UICSpacer(vertical: 15, horizontal: 30) {
                                    UICHStack(spacing: 15) {[
                                        UICCenter {
                                            UICSpacer {
                                                UICRounder(radius: 15) {
                                                    BackgroundView(254333)
                                                }.onTap { _ in
                                                    self.moveToPage(0)
                                                }
                                            }.aspectRatio()
                                            .top()
                                            .bottom()
                                        },
                                        UICCenter {
                                            UICSpacer {
                                                UICRounder(radius: 15) {
                                                    BackgroundView(10254333)
                                                }.onTap { _ in
                                                    self.moveToPage(1)
                                                }
                                            }.aspectRatio()
                                            .top()
                                            .bottom()
                                        },
                                        UICCenter {
                                            UICSpacer {
                                                UICRounder(radius: 15) {
                                                    BackgroundView(50254333)
                                                }.onTap { _ in
                                                    self.moveToPage(2)
                                                }
                                            }.aspectRatio()
                                            .top()
                                            .bottom()
                                        }
                                    ]}.distribution(.fillEqually)
                                    .height(equalTo: 70)
                                }.insets()
                            ]}
                        }
                    ]}
                }.insets()
            }.insets()
            .as(self.$pageViewController)
            .onPageChanged { [unowned self] in 
                self.pageView.currentPage = $0
            }
    }
}
