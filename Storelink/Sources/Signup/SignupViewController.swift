//
//  SignupViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 11/28/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit
import InputMask

final class SignupViewController: InitialViewController {
    
    private let viewModel: SignupViewModel
    
    private let closeBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = Assets.close.image
        barButton.tintColor = .black
        return barButton
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Storelink!"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let usernameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Username"
        return textField
    }()
    
    private let emailTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private let passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    private let passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.text = "Password must containt at least 8 characters"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let repeatPasswordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Repeat password"
        return textField
    }()
    
    private let actionButton = MainButton(title: "Create")
    
    var coordinator: SignupFlow?
    
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
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
        [welcomeLabel, usernameTextField, emailTextField, passwordTextField, passwordValidationLabel, repeatPasswordTextField, actionButton].forEach {
            view.addSubview($0)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
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

        repeatPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
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
        closeBarButtonItem.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
        
        let input = SignupViewModel.Input(username: usernameTextField.rx.text.asObservable().filterNil(),
                                          email: emailTextField.rx.text.asObservable().filterNil(),
                                          password: passwordTextField.rx.text.asObservable().filterNil(),
                                          repeatPassword: repeatPasswordTextField.rx.text.asObservable().filterNil(),
                                          buttonTrigger: actionButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
    }
    
}
