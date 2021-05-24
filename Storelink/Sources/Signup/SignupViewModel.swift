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
        let username: BehaviorRelay<String>
        let email: Observable<String>
        let password: Observable<String>
        let repeatPassword: Observable<String>
        let buttonTrigger: Observable<Void>
    }
    
    struct Output {
        
    }
    
    private let username: BehaviorRelay<String> = .init(value: "")
    private let email: BehaviorRelay<String> = .init(value: "")
    private let password: BehaviorRelay<String> = .init(value: "")
    private let repeatPassword: BehaviorRelay<String> = .init(value: "")
    
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
        
        return Output()
    }
    
    func postRequest() {
        let usernameValue = username.value
        let emailValue = email.value
        let passwordValue = password.value
        let repeatPasswordValue = repeatPassword.value
        
        let user = UserRequest(username: "qwertsdfy123", email: "asdasdfqw@gmail.com", password: "111232324")
        NetworkManager.shared.postRegistration(request: user)
            .subscribe { [weak self] _ in
                
            } onError: { errorMessage in
                print(errorMessage)
            }
            .disposed(by: disposeBag)
    }
}
