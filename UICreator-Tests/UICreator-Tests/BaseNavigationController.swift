//
//  BaseNavigationController.swift
//  Pods-Teste1
//
//  Created by brennobemoura on 21/12/19.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = .white
        navigationBar.barStyle = .default
        navigationBar.barTintColor = .clear

        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }

    // MARK: UI

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last?.preferredStatusBarStyle ?? .lightContent
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        if self.viewControllers.count == 1 {
            if self.presentingViewController != nil {
                let first = self.viewControllers.first
                self.dismiss(animated: animated, completion: nil)
                return first
            }
        }

        return super.popViewController(animated: animated)
    }
}

import UICreator

class Navigation: UICViewControllerRepresentable {
    typealias ViewController = BaseNavigationController

    let content: () -> ViewCreator

    init(_ content: @escaping () -> ViewCreator) {
        self.content = content
    }

    func makeUIViewController() -> BaseNavigationController {
        BaseNavigationController(rootViewController: UICHostingController(rootView: self.content()))
    }

    func updateUIViewController(_ uiViewController: BaseNavigationController) {}
}
