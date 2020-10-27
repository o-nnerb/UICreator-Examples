//
//  ViewController.swift
//  Teste1
//
//  Created by brennobemoura on 18/12/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import UIKit
import UICreator

extension SignupView {
    func TextField(placeholder: String,_ value: Relay<String?>) -> UICModifiedView<UICTextField.View> {
        UICTextField(placeholder: placeholder, value)
            .font(UIFont.boldSystemFont(ofSize: 24))
            .textColor(.white)
            .borderStyle(.none)
            .height(equalTo: 55)
            .placeholderColor(.white)
            .placeholderFont(.systemFont(ofSize: 24, weight: .regular))
    }

    func Spacer(_ handler: @escaping () -> ViewCreator) -> UICAnyView {
        UICAnyView(
            UICRounder(radius: .zero) {
                UICSpacer(vertical: 0, horizontal: 10) {
                    handler()
                }
            }
            .borderColor(.white)
            .borderWidth(1)
        )
    }
}

struct SignupView: UICView {
    @Value var name: String?
    @Value var lastName: String?
    @Value var state: String?
    @Value var city: String?
    @Value var street: String?
    @Value var number: String?
    @Value var date: Date?
    @Value var isAccepted: Bool = false

    @Value var navigationTitle: String?
    // Indented to cause a loop when user push SignupView
    @Value var isSignupPushing: Bool = false

    @Relay var isPushed: Bool


    init(_ isPushed: Relay<Bool>) {
        self._isPushed = isPushed
    }

    var body: ViewCreator {
        UICNavigationLink(self.$isSignupPushing) {
            SignupView(self.$isSignupPushing)
        } content: {
            UICZStack {
                UICImage(uiImage: #imageLiteral(resourceName: "waterfall"))
                    .contentMode(.fill)
                    .insets()
                    .clipsToBounds(true)

                UICVStack {
                    UICForEach(Array(0...20)) {
                        UICSpacer()
                            .backgroundColor(.init(white: CGFloat($0) / 40, alpha: 1))
                    }
                }
                .distribution(.fillEqually)

                UICSpacer()
                    .backgroundColor(.black)
                    .alpha(0.35)

                UICVScroll {
                    UICVStack {
                        UICSpacer(spacing: 15) {
                            UICVStack(spacing: 30) {
                                Spacer {
                                    TextField(placeholder: "Nome", self.$name)
                                        .keyboardType(.asciiCapable)
                                        .inputView {
                                            UICInput(style: .keyboard) {
                                                UICDatePicker(
                                                    maximumDate: .init(),
                                                    selectedDate: self.$date
                                                )
                                                .tintColor(.black)
                                                .insets(priority: .required)
                                            }
                                        }
                                        .onEditingChanged {
                                            self.navigationTitle = ($0 as? UITextField)?.text
                                        }
                                        .leftView {
                                            UICSpacer(spacing: 5) {
                                                UICHStack(spacing: 5) {
                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .backgroundColor(.red)
                                                            .aspectRatio(priority: .defaultLow)
                                                    }

                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .backgroundColor(.black)
                                                            .aspectRatio(priority: .defaultLow)
                                                    }

                                                    UICRounder(radius: 0.5) {
                                                        UICSpacer()
                                                            .backgroundColor(.green)
                                                            .aspectRatio(priority: .defaultLow)
                                                    }
                                                }
                                            }
                                            .height(equalTo: 55)
                                        }
                                }

                                Spacer {
                                    TextField(placeholder: "Sobrenome", $lastName)
                                        .keyboardType(.asciiCapable)
                                }

                                UICSpacer(vertical: 15, horizontal: .zero) {
                                    UICVStack(spacing: 30) {
                                        Spacer {
                                            TextField(placeholder: "Estado", self.$state)
                                                .keyboardType(.asciiCapable)
                                        }

                                        Spacer {
                                            TextField(placeholder: "Cidade", self.$city)
                                                .keyboardType(.asciiCapable)
                                        }

                                        UICHStack(spacing: 30) {
                                            Spacer {
                                                TextField(placeholder: "Rua", self.$street)
                                                    .keyboardType(.asciiCapable)
                                            }

                                            Spacer {
                                                TextField(placeholder: "Número", self.$number)
                                                    .keyboardType(.asciiCapable)
                                            }
                                            .width(equalToSuperview: 0.35)
                                            .navigation(title: "Cadastro")
                                            .navigation(background: .init(uiImage: #imageLiteral(resourceName: "waterfall")))
                                            .navigation(titleColor: .white)
                                            .navigation(backButton: {
                                                UICButton("Sair")
                                                    .titleColor(.white)
                                                    .onTouchInside { _ in
                                                        self.isPushed = false
                                                    }
                                            })
                                        }
                                    }
                                }

                                Spacer {
                                    TextField(placeholder: "Gênero", .constant(nil))
                                }

                                Spacer {
                                    TextField(placeholder: "CPF", .constant(nil))
                                }

                                Spacer {
                                    TextField(placeholder: "Senha", .constant(nil))
                                        .isSecureTextEntry()
                                }

                                UICHStack {
                                    UICLabel("Aceito os termos")
                                        .textColor(.black)

                                    UICSwitch(isOn: self.$isAccepted)
                                }

                                UICSpacer()
                            }
                        }

                        UICSpacer(vertical: 0, horizontal: 15) {
                            UICRounder(radius: 5) {
                                UICButton("Save")
                                    .titleColor(.black)
                                    .backgroundColor(.brown)
                                    .height(equalTo: 55)
                                    .onTouchInside { _ in
                                        self.navigationTitle = "Submitted"
                                        self.isSignupPushing = true
                                    }
                                    .makeAccessibility()
                                    .onGrayScaleChanged {
                                        $0.backgroundColor = UIAccessibility.isGrayscaleEnabled ? UIColor(white: 0.5, alpha: 1) : .brown
                                    }
                            }
                        }
                        .shadowOffset(x: 2, y: 3)
                        .shadowRadius(3)
                        .shadowOcupacity(0.45)
                    }
                }
                .insets()
                .insetsBehavior(.always)
            }
            .backgroundColor(.white)
            .navigation(title: $isAccepted.withLatest(self.$navigationTitle) {
                $0 ? "Aceito" : $1
            })
        }
    }
}
