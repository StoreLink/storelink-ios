//
//  LoginViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 11/28/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit
import InputMask

final class LoginViewController: InitialViewController {
    
    private enum Constants {
        static let phoneFormat = "+7 ([000])-[000]-[00]-[00]"
    }
    
    private lazy var phoneMask: MaskedTextFieldDelegate = {
        let mask = MaskedTextFieldDelegate(primaryFormat: Constants.phoneFormat)
        mask.delegate = self
        return mask
    }()
    
    private lazy var phoneNumberTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Strings.phoneNumber
        textField.delegate = phoneMask
        return textField
    }()
    
    private lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Strings.password
        textField.isSecureTextEntry = true
        textField.rightView = passwordRightButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private let loginButton = MainButton(title: Strings.login)
    
    private let passwordRightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Assets.eye.image, for: .normal)
        return button
    }()
    
    var coordinator: LoginFlow?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.login
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
            $0.height.equalTo(45)
        }
    }
    
    override func bind() {
        loginButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        passwordRightButton.rx.tap.bind { [weak self] in
            self?.passwordTextField.isSecureTextEntry.toggle()
            (self?.passwordTextField.isSecureTextEntry ?? true) ? self?.passwordRightButton.setImage(Assets.eye.image, for: .normal) : self?.passwordRightButton.setImage(Assets.eyeInvisible.image, for: .normal)
        }.disposed(by: disposeBag)
    }
}
