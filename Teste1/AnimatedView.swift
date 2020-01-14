//
//  AnimatedView.swift
//  Teste1
//
//  Created by brennobemoura on 07/01/20.
//  Copyright © 2020 brennobemoura. All rights reserved.
//

import Foundation
import UICreator
import UIContainer

class AnimatedView: Root {
    weak var contentView: UIView!
    weak var view: RounderView!
    var roundCount: Int = 1
}

extension AnimatedView: TemplateView {
    var body: ViewCreator {
        Center {
            Rounder(radius: 0) {
                Spacer()
                    .aspectRatio()
                    .background(color: .orange)
                    .onTouch { _ in
                        self.animateView()
                }.height(equalTo: 60)
            }.as(&self.view)
        }.background(color: .black)
        .as(&self.contentView)
        .insets()
        .onPanMaker {
            $0.onChanged {
                print($0.translation(in: self.contentView))
            }
        }
    }
}

extension AnimatedView {
    func animateView() {

        guard roundCount < 6 else {
            return
        }
        self.animateWithKeyframes(1, animations: .init(
            .keyframe(startAt: 0.0, duration: 0.25) { _ in
                self.view.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0.25)
            },
            .keyframe(startAt: 0.25, duration: 0.5) { _ in
                self.view.transform = self.view.transform.rotated(by: CGFloat.pi * 0.75)
            },
            .keyframe(startAt: 0.75, duration: 0.25) { _ in
                self.view.transform = self.view.transform.rotated(by: CGFloat.pi * 1)
            },
            .keyframe(startAt: 0, duration: 1, animations: { _ in
                self.view.radius = (CGFloat(self.roundCount) / 6) * 0.5
            })
        ), completion: { didEnd in
            guard didEnd else {
                return
            }
            self.view.transform = CGAffineTransform(rotationAngle: 0)

            if self.roundCount < 6 {
                self.roundCount += 1
            }
        })
    }
}
