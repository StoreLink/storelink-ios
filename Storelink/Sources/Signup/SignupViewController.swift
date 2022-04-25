//
//  SignupViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 11/28/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import InputMask
import UIKit

final class SignupViewController: InitialViewController {
    private let viewModel: SignupViewModel

    private let closeBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = Assets.close.image
        barButton.tintColor = .black
        return barButton
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.logo.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Storelink!"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let usernameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Username"
        textField.autocorrectionType = .no
        return textField
    }()

    private let emailTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Email"
        textField.autocorrectionType = .no
        return textField
    }()

    private lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Password"
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        textField.rightView = passwordRightButton
        return textField
    }()

    private let passwordRightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Assets.eye.image, for: .normal)
        return button
    }()

    private let passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.text = "Password must containt at least 8 characters"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()

    private lazy var repeatPasswordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Repeat password"
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        textField.rightView = repeatPasswordRightButton
        return textField
    }()

    private let repeatPasswordRightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Assets.eye.image, for: .normal)
        return button
    }()

    private let actionButton = MainButton(title: "Create")

    var coordinator: SignupFlow?

    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
    }

    @available(*, unavailable)
    required convenience init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.signup
    }

    override func setNavigationLeftBarButton() {
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }

    override func setupUI() {
        [logoImageView, welcomeLabel, usernameTextField, emailTextField, passwordTextField, passwordValidationLabel, repeatPasswordTextField, actionButton].forEach {
            view.addSubview($0)
        }

        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }

        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(25)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

        passwordValidationLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        repeatPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordValidationLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

        actionButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-30)
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

        repeatPasswordRightButton.rx.tap.bind { [weak self] in
            self?.repeatPasswordTextField.isSecureTextEntry.toggle()
            (self?.repeatPasswordTextField.isSecureTextEntry ?? true) ? self?.repeatPasswordRightButton.setImage(Assets.eye.image, for: .normal) : self?.repeatPasswordRightButton.setImage(Assets.eyeInvisible.image, for: .normal)
        }.disposed(by: disposeBag)

        let input = SignupViewModel.Input(username: usernameTextField.rx.text.asObservable().filterNil(),
                                          email: emailTextField.rx.text.asObservable().filterNil(),
                                          password: passwordTextField.rx.text.asObservable().filterNil(),
                                          repeatPassword: repeatPasswordTextField.rx.text.asObservable().filterNil(),
                                          buttonTrigger: actionButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)

        output.showAlert.subscribe(onNext: { [weak self] message in
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.navigationController?.present(alert, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)

        output.showLoginTrigger.subscribe(onNext: { [weak self] in
            self?.coordinator?.showLoginView()
        })
        .disposed(by: disposeBag)
    }
}
