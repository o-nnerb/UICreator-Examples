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

extension TextField {
    static func base(_ placeholder: String) -> Field {
        Field(placeholder: placeholder)
            .font(UIFont.boldSystemFont(ofSize: 24))
            .text(color: .white)
            .border(style: .none)
            .height(equalTo: 55)
            .placeholder(color: .white)
            .placeholder(font: .systemFont(ofSize: 24, weight: .regular))
    }

    static func spacer(_ handler: @escaping () -> ViewCreator) -> Spacer {
        Spacer(vertical: 0, horizontal: 10) {
            handler()
        }.border(color: .white)
        .border(width: 1)
        .corner(radius: 5)
    }
}

class ContentView: Root, TemplateView, ViewControllerType {
    var body: ViewCreator {
        Spacer {
            Navigation {
                ForEachView()
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
            Image(image: nil)
                .image(#imageLiteral(resourceName: "GettyImages-139496979"))
                .content(mode: .scaleAspectFill)
                .insets()
                .clips(toBounds: true),
            Stack(
                (0...20).map {
                    Spacer()
                        .background(color: .init(white: CGFloat($0) / 40, alpha: 1))
                }
            ).distribution(.fillEqually),
            Spacer()
                .background(color: .black)
                .alpha(0.35),
            Scroll {
                Stack(
                    Spacer(spacing: 15) {
                        Stack(
                            TextField.spacer {
                                TextField.base("Nome")
                                    .keyboard(type: .asciiCapable)
                                    .as(&self.nameField)
                                    .inputView {
                                        Input(size: .init(width: UIScreen.main.bounds.width, height: 250), style: .keyboard) {
                                            DatePicker(calendar: nil)
                                                .maximumDate(.init())
                                                .tintColor(.black)
                                                .mode(.date)
                                                .insets(priority: .required)
                                                .as(&self.datePicker)
                                        }
                                    }.onEditingChanged {
                                        $0.navigationItem.title = ($0 as? UITextField)?.text
                                    }.leftView {
                                        Content {
                                            Spacer(spacing: 5) {
                                                Stack(axis: .horizontal, .init(
                                                    Rounder(radius: 0.5) {
                                                        Spacer()
                                                            .background(color: .red)
                                                            .aspectRatio(priority: .low)
                                                    },
                                                    Rounder(radius: 0.5) {
                                                        Spacer()
                                                            .background(color: .black)
                                                            .aspectRatio(priority: .low)
                                                    },
                                                    Rounder(radius: 0.5) {
                                                        Spacer()
                                                            .background(color: .green)
                                                            .aspectRatio(priority: .low)
                                                    }
                                                )).spacing(5)
                                            }
                                        }.content(mode: .scaleAspectFit).height(equalTo: 55)
                                    }
                            },
                            TextField.spacer {
                                TextField.base("Sobrenome")
                                    .keyboard(type: .asciiCapable)
                                    .as(&self.lastNameField)
                            },
                            Spacer(vertical: 15, horizontal: 0) {
                                Stack(
                                    TextField.spacer {
                                        TextField.base("Estado")
                                            .keyboard(type: .asciiCapable)
                                            .as(&self.stateField)
                                    },
                                    TextField.spacer {
                                        TextField.base("Cidade")
                                            .keyboard(type: .asciiCapable)
                                            .as(&self.cityField)
                                    },
                                    Stack(axis: .horizontal, .init(
                                        TextField.spacer {
                                            TextField.base("Rua")
                                                .keyboard(type: .asciiCapable)
                                                .as(&self.streetField)
                                        },
                                        TextField.spacer {
                                            TextField.base("Número")
                                                .keyboard(type: .asciiCapable)
                                        }.width(equalToSuperview: 0.35)
                                        .navigation(title: "Cadastro")
                                        .navigation(background: #imageLiteral(resourceName: "GettyImages-139496979"))
                                        .navigation(titleColor: .white)
                                        .navigation(backButton: {
                                            Button("Sair")
                                                .title(color: .black)
                                                .onTouchInside {
                                                    $0.navigation?.pop(animated: true)
                                                }
                                        })
                                    )).spacing(30)
                                ).spacing(30)
                            },
                            TextField.spacer {
                                TextField.base("Gênero")
                            },
                            TextField.spacer {
                                TextField.base("CPF")
                            },
                            TextField.spacer {
                                TextField.base("Senha")
                                    .secureText()
                            },
                            HStack(
                                Label("Aceito os termos")
                                    .text(color: .black),
                                Switch(on: false)
                                    .onValueChanged {
                                        $0.navigationItem.title = "Aceito"
                                    }
                            ),
                            Spacer()
                        ).spacing(30)
                    },
                    Spacer(vertical: 0, horizontal: 15) {
                            Rounder(radius: 5) {
                                Button("Save")
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
