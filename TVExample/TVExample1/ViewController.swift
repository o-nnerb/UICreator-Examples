//
//  ViewController.swift
//  Teste1
//
//  Created by brennobemoura on 18/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import UIKit
import UICreator

extension UICText {
    static func base(_ placeholder: String) -> UICText {
        UICText(placeholder: placeholder)
            .font(UIFont.boldSystemFont(ofSize: 24))
            .textColor(.white)
            .borderStyle(.none)
            .height(equalTo: 55)
            .placeholder(color: .white)
            .placeholder(font: .systemFont(ofSize: 24, weight: .regular))
    }

    static func spacer(_ handler: @escaping () -> ViewCreator) -> UICSpacer {
        UICSpacer(vertical: 0, horizontal: 10) {
            handler()
        }.borderColor(.white)
        .borderWidth(1)
        .cornerRadius(5)
    }
}

class ContentView: UICView {
    var body: ViewCreator {
        UICSpacer {
            UICNavigation {
                ListView()
            }
        }.backgroundColor(.white)
    }
}

class SignupView: UICView {
    @UICOutlet var nameField: UITextField!
    @UICOutlet var lastNameField: UITextField!
    @UICOutlet var stateField: UITextField!
    @UICOutlet var cityField: UITextField!
    @UICOutlet var streetField: UITextField!
}

extension SignupView {

    var body: ViewCreator {
        UICZStack {[
            UICImage(image: nil)
                .image(#imageLiteral(resourceName: "GettyImages-139496979"))
                .content(mode: .scaleAspectFill)
                .insets()
                .clipsToBounds(true),
            UICVStack {
                (0...20).map {
                    UICSpacer()
                        .backgroundColor(.init(white: CGFloat($0) / 40, alpha: 1))
                }
            }.distribution(.fillEqually),
            UICSpacer()
                .backgroundColor(.black)
                .alpha(0.35),
            UICScroll {
                UICVStack {[
                    UICSpacer(spacing: 15) {
                        UICVStack {[
                            UICSegmented {[
                                    Segment(content: .text("Teste"))
                                        .onSelected {
                                            $0.navigationItem.title = "Teste"
                                        }.isSelected(true),
                                    Segment(content: .text("Opa"))
                                        .onSelected {
                                            $0.navigationItem.title = "Opa"
                                        }
                                ]}.backgroundColor(.yellow)
                                .selectedTintColor(.blue),
                            UICText.spacer {
                                UICText.base("Nome")
                                    .keyboardType(.asciiCapable)
                                    .as(self.$nameField)
                                    .onEditingChanged {
                                        $0.navigationItem.title = ($0 as? UITextField)?.text
                                    }.leftView {
                                        UICSpacer {
                                            UICSpacer(spacing: 5) {
                                                UICHStack {[
                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .backgroundColor(.red)
                                                            .aspectRatio(priority: .defaultLow)
                                                    },
                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .backgroundColor(.black)
                                                            .aspectRatio(priority: .defaultLow)
                                                    },
                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .backgroundColor(.green)
                                                            .aspectRatio(priority: .defaultLow)
                                                    }
                                                ]}.spacing(5)
                                            }
                                        }
                                        .height(equalTo: 55)
                                    }
                            },
                            UICText.spacer {
                                UICText.base("Sobrenome")
                                    .keyboardType(.asciiCapable)
                                    .as(self.$lastNameField)
                            },
                            UICSpacer(vertical: 15, horizontal: 0) {
                                UICVStack {[
                                    UICText.spacer {
                                        UICText.base("Estado")
                                            .keyboardType(.asciiCapable)
                                            .as(self.$stateField)
                                    },
                                    UICText.spacer {
                                        UICText.base("Cidade")
                                            .keyboardType(.asciiCapable)
                                            .as(self.$cityField)
                                    },
                                    UICHStack {[
                                        UICText.spacer {
                                            UICText.base("Rua")
                                                .keyboardType(.asciiCapable)
                                                .as(self.$streetField)
                                        },
                                        UICText.spacer {
                                            UICText.base("Número")
                                                .keyboardType(.asciiCapable)
                                        }.width(equalToSuperview: 0.35)
                                        .navigation(title: "Cadastro")
                                        .navigation(background: #imageLiteral(resourceName: "GettyImages-139496979"))
                                        .navigation(titleColor: .white)
                                        /*.navigation(backButton: {
                                            UICButton("Sair")
                                                .title(color: .black)
                                                .onTouchInside {
                                                    $0.navigation?.pop(animated: true)
                                                }
                                        })*/
                                    ]}.spacing(30)
                                ]}.spacing(30)
                            },
                            UICText.spacer {
                                UICText.base("Gênero")
                            },
                            UICText.spacer {
                                UICText.base("CPF")
                            },
                            UICText.spacer {
                                UICText.base("Senha")
                                    .isSecureTextEntry()
                            },
                            UICSpacer()
                        ]}.spacing(30)
                    },
                    UICSpacer(vertical: 0, horizontal: 15) {
                            UICRounder(radius: 5) {
                                UICButton("Save")
                                    .title(color: .black)
                                    .backgroundColor(.brown)
                                    .height(equalTo: 55)
                                    .onTouchInside {
                                        $0.navigationItem.title = "Submitted"
                                        $0.navigation?.push(animated: true) {
                                            SignupView()
                                        }
                                    }.accessibily {
                                        $0.onGrayScaleChanged {
                                            $0.backgroundColor = UIAccessibility.isGrayscaleEnabled ? UIColor(white: 0.5, alpha: 1) : .brown
                                        }
                                    }
                            }
                        }.shadowOffset(.init(width: 2, height: 3))
                        .shadowRadius(3)
                        .shadowOcupacity(0.45),
                    UICSpacer(vertical: 0, horizontal: 15) {
                            UICRounder(radius: 5) {
                                UICButton("Present")
                                    .title(color: .black)
                                    .backgroundColor(.brown)
                                    .height(equalTo: 55)
                                    .onTouchInside {
                                        $0.navigationItem.title = "Submitted"
                                        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = UIViewController()
//                                        $0.navigation?.present(animated: true) {
//                                            ListView()
//                                        }
                                    }.accessibily {
                                        $0.onGrayScaleChanged {
                                            $0.backgroundColor = UIAccessibility.isGrayscaleEnabled ? UIColor(white: 0.5, alpha: 1) : .brown
                                        }
                                    }
                            }
                        }.shadowOffset(.init(width: 2, height: 3))
                        .shadowRadius(3)
                        .shadowOcupacity(0.45)
                ]}
            }.insets()
            .insets(behavior: .always)
        ]}.backgroundColor(.white)
    }
}
