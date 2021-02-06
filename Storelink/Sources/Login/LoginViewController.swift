//
//  LoginViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 11/28/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

class LoginViewController: InitialViewController {
    
    private let phoneNumberTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Номер телефона"
        return textField
    }()
    
    private lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        textField.rightView = passwordRightButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private let loginButton: MainButton = {
        let button = MainButton(title: "Вход")
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let passwordRightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Assets.eye.image, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Вход"
    }
    
    override func setupUI() {
        [phoneNumberTextField, passwordTextField, loginButton].forEach {
            view.addSubview($0)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
    @objc func loginButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
