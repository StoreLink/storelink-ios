//
//  SignupViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 17.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignupViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let username: Observable<String>
        let email: Observable<String>
        let password: Observable<String>
        let repeatPassword: Observable<String>
        let buttonTrigger: Observable<Void>
    }
    
    struct Output {
        let showAlert: Observable<String>
        let showLoginTrigger: Observable<Void>
    }
    
    private let username: BehaviorRelay<String> = .init(value: "")
    private let email: BehaviorRelay<String> = .init(value: "")
    private let password: BehaviorRelay<String> = .init(value: "")
    private let repeatPassword: BehaviorRelay<String> = .init(value: "")
    private let outShowAlert: PublishRelay<String> = .init()
    private let outShowLoginTrigger: PublishRelay<Void> = .init()
    
    func transform(input: Input) -> Output {
        input.username
            .bind(to: username)
            .disposed(by: disposeBag)
        
        input.email
            .bind(to: email)
            .disposed(by: disposeBag)
        
        input.password
            .bind(to: password)
            .disposed(by: disposeBag)
        
        input.repeatPassword
            .bind(to: repeatPassword)
            .disposed(by: disposeBag)
        
        input.buttonTrigger.subscribe(onNext: { [weak self] in
            self?.postRequest()
        })
        .disposed(by: disposeBag)
        
        return Output(showAlert: outShowAlert.asObservable(),
                      showLoginTrigger: outShowLoginTrigger.asObservable())
    }
    
    func postRequest() {
        let usernameValue = username.value
        let emailValue = email.value
        let passwordValue = password.value
        let repeatPasswordValue = repeatPassword.value
        
        guard usernameValue.isNotEmpty, emailValue.isNotEmpty,
              passwordValue.isNotEmpty, repeatPasswordValue.isNotEmpty else {
            outShowAlert.accept("Fill all fields")
            return
        }
        
        guard isValidEmail(emailValue) else {
            outShowAlert.accept("Enter valid email address")
            return
        }
        
        guard passwordValue.count >= 8, passwordValue == repeatPasswordValue else {
            outShowAlert.accept("Password must containt at least 8 characters and passwords must match")
            return
        }
        
        NetworkManager.shared.postRegistration(username: usernameValue, email: emailValue, password: passwordValue)
            .trackActivity(loading)
            .subscribe { [weak self] _ in
                self?.outShowLoginTrigger.accept(())
            } onError: { errorMessage in
                print(errorMessage)
            }
            .disposed(by: disposeBag)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
