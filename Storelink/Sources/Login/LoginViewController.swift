//
//  LoginViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 11/28/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import InputMask
import RxCocoa
import RxSwift
import UIKit

final class LoginViewController: InitialViewController {
    private let viewModel: LoginViewModel
    var coordinator: LoginFlow?

    private let closeBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = Assets.close.image
        barButton.tintColor = .black
        return barButton
    }()

    private lazy var usernameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Username"
        textField.autocorrectionType = .no
        return textField
    }()

    private lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Strings.password
        textField.isSecureTextEntry = true
        textField.rightView = passwordRightButton
        textField.rightViewMode = .always
        textField.autocorrectionType = .no
        return textField
    }()

    private let loginButton = MainButton(title: Strings.login)

    private let passwordRightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Assets.eye.image, for: .normal)
        return button
    }()

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    @available(*, unavailable)
    required convenience init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.login
    }

    override func setNavigationLeftBarButton() {
        super.setNavigationLeftBarButton()
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }

    override func setupUI() {
        [usernameTextField, passwordTextField, loginButton].forEach {
            view.addSubview($0)
        }

        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
    }

    override func bind() {
        viewModel.loading
            .asObservable()
            .bind { [weak self] loading in
                loading ? self?.startLoader() : self?.stopLoader()
            }
            .disposed(by: disposeBag)

        closeBarButtonItem.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        .disposed(by: disposeBag)

        passwordRightButton.rx.tap.bind { [weak self] in
            self?.passwordTextField.isSecureTextEntry.toggle()
            (self?.passwordTextField.isSecureTextEntry ?? true) ? self?.passwordRightButton.setImage(Assets.eye.image, for: .normal) : self?.passwordRightButton.setImage(Assets.eyeInvisible.image, for: .normal)
        }.disposed(by: disposeBag)

        let input = LoginViewModel.Input(
            userName: usernameTextField.rx.text.asObservable().filterNil(),
            password: passwordTextField.rx.text.asObservable().filterNil(),
            loginButtonTrigger: loginButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.showAlert.subscribe(onNext: { [weak self] message in
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.navigationController?.present(alert, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)

        output.loginTrigger
            .subscribe(onNext: { [weak self] in
                NotificationCenter.default.post(name: .loginSuccess, object: nil)
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
