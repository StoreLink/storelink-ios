//
//  SignupPhoneViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 11/28/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit
import InputMask

final class SignupPhoneViewController: InitialViewController {
    
    private enum Constants {
        static let phoneFormat = "+7 ([000])-[000]-[00]-[00]"
    }
    
    private lazy var phoneMask: MaskedTextFieldDelegate = {
        let mask = MaskedTextFieldDelegate(primaryFormat: Constants.phoneFormat)
        mask.delegate = self
        return mask
    }()
    
    private lazy var phoneTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = Strings.phoneNumber
        textField.delegate = phoneMask
        return textField
    }()
    
    private let continueButton = MainButton(title: Strings.continue)
    
    var coordinator: SignupFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.signup
    }
    
    override func setupUI() {
        [phoneTextField, continueButton].forEach {
            view.addSubview($0)
        }
        
        continueButton.activateConstraint()
        
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
    override func bind() {
        continueButton.rx.tap.bind { [weak self] in
            self?.coordinator?.showOTPView(phoneNumber: self?.phoneTextField.text ?? "")
        }.disposed(by: disposeBag)
    }
    
}
