//
//  ViewController.swift
//  Teste1
//
//  Created by brennobemoura on 18/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import UIKit
import UIContainer
import UICreator

extension UICText {
    static func base(_ placeholder: String) -> UICText {
        UICText(placeholder: placeholder)
            .font(UIFont.boldSystemFont(ofSize: 24))
            .text(color: .white)
            .border(style: .none)
            .height(equalTo: 55)
            .placeholder(color: .white)
            .placeholder(font: .systemFont(ofSize: 24, weight: .regular))
    }

    static func spacer(_ handler: @escaping () -> ViewCreator) -> UICSpacer {
        UICSpacer(vertical: 0, horizontal: 10) {
            handler()
        }.border(color: .white)
        .border(width: 1)
        .corner(radius: 5)
    }
}

class ContentView: Root, TemplateView, ViewControllerType {
    var body: ViewCreator {
        UICSpacer {
            Navigation {
                ListView()
            }
        }.background(color: .white)
    }
}

class SignupView: Root, TemplateView {
    weak var nameField: UITextField!
    weak var lastNameField: UITextField!
    weak var stateField: UITextField!
    weak var cityField: UITextField!
    weak var streetField: UITextField!
    weak var datePicker: UIDatePicker!
//    var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SignupView {

    var body: ViewCreator {
        Child(
            UICImage(image: nil)
                .image(#imageLiteral(resourceName: "GettyImages-139496979"))
                .content(mode: .scaleAspectFill)
                .insets()
                .clips(toBounds: true),
            UICStack(
                (0...20).map {
                    UICSpacer()
                        .background(color: .init(white: CGFloat($0) / 40, alpha: 1))
                }
            ).distribution(.fillEqually),
            UICSpacer()
                .background(color: .black)
                .alpha(0.35),
            UICScroll {
                UICStack(
                    UICSpacer(spacing: 15) {
                        UICStack(
                            UICText.spacer {
                                UICText.base("Nome")
                                    .keyboard(type: .asciiCapable)
                                    .as(&self.nameField)
                                    .inputView {
                                        UICInput(size: .init(width: UIScreen.main.bounds.width, height: 250), style: .keyboard) {
                                            UICDatePicker(calendar: nil)
                                                .maximumDate(.init())
                                                .tintColor(.black)
                                                .mode(.date)
                                                .insets(priority: .required)
                                                .as(&self.datePicker)
                                        }
                                    }.onEditingChanged {
                                        $0.navigationItem.title = ($0 as? UITextField)?.text
                                    }.leftView {
                                        UICContent {
                                            UICSpacer(spacing: 5) {
                                                UICStack(axis: .horizontal, .init(
                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .background(color: .red)
                                                            .aspectRatio(priority: .low)
                                                    },
                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .background(color: .black)
                                                            .aspectRatio(priority: .low)
                                                    },
                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .background(color: .green)
                                                            .aspectRatio(priority: .low)
                                                    }
                                                )).spacing(5)
                                            }
                                        }.content(mode: .scaleAspectFit).height(equalTo: 55)
                                    }
                            },
                            UICText.spacer {
                                UICText.base("Sobrenome")
                                    .keyboard(type: .asciiCapable)
                                    .as(&self.lastNameField)
                            },
                            UICSpacer(vertical: 15, horizontal: 0) {
                                UICStack(
                                    UICText.spacer {
                                        UICText.base("Estado")
                                            .keyboard(type: .asciiCapable)
                                            .as(&self.stateField)
                                    },
                                    UICText.spacer {
                                        UICText.base("Cidade")
                                            .keyboard(type: .asciiCapable)
                                            .as(&self.cityField)
                                    },
                                    UICStack(axis: .horizontal, .init(
                                        UICText.spacer {
                                            UICText.base("Rua")
                                                .keyboard(type: .asciiCapable)
                                                .as(&self.streetField)
                                        },
                                        UICText.spacer {
                                            UICText.base("Número")
                                                .keyboard(type: .asciiCapable)
                                        }.width(equalToSuperview: 0.35)
                                        .navigation(title: "Cadastro")
                                        .navigation(background: #imageLiteral(resourceName: "GettyImages-139496979"))
                                        .navigation(titleColor: .white)
                                        .navigation(backButton: {
                                            UICButton("Sair")
                                                .title(color: .black)
                                                .onTouchInside {
                                                    $0.navigation?.pop(animated: true)
                                                }
                                        })
                                    )).spacing(30)
                                ).spacing(30)
                            },
                            UICText.spacer {
                                UICText.base("Gênero")
                            },
                            UICText.spacer {
                                UICText.base("CPF")
                            },
                            UICText.spacer {
                                UICText.base("Senha")
                                    .secureText()
                            },
                            UICHStack(
                                UICLabel("Aceito os termos")
                                    .text(color: .black),
                                UICSwitch(on: false)
                                    .onValueChanged {
                                        $0.navigationItem.title = "Aceito"
                                    }
                            ),
                            UICSpacer()
                        ).spacing(30)
                    },
                    UICSpacer(vertical: 0, horizontal: 15) {
                            UICRounder(radius: 5) {
                                UICButton("Save")
                                    .title(color: .black)
                                    .background(color: .brown)
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
                        }.shadow(offset: .init(width: 2, height: 3))
                        .shadow(radius: 3)
                        .shadow(ocupacity: 0.45)
                )
            }.insets()
            .insets(behavior: .always)
        ).background(color: .white)
    }
}
