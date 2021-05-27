//
//  LoginViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 25.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let userName: Observable<String>
        let password: Observable<String>
        let loginButtonTrigger: Observable<Void>
    }
    
    struct Output {
        let showAlert: Observable<String>
        let loginTrigger: Observable<Void>
    }
    
    private let userName: BehaviorRelay<String> = .init(value: "")
    private let password: BehaviorRelay<String> = .init(value: "")
    private let outShowAlert: PublishRelay<String> = .init()
    private let outLoginTrigger: PublishRelay<Void> = .init()
    
    func transform(input: Input) -> Output {
        input.userName
            .bind(to: userName)
            .disposed(by: disposeBag)
        
        input.password
            .bind(to: password)
            .disposed(by: disposeBag)
        
        input.loginButtonTrigger
            .bind(onNext: { [weak self] in
                self?.loginRequest()
            })
            .disposed(by: disposeBag)
        
        return Output(showAlert: outShowAlert.asObservable(),
                      loginTrigger: outLoginTrigger.asObservable())
    }
    
    func loginRequest() {
        let userNameValue = userName.value
        let passwordValue = password.value
        
        guard userNameValue.isNotEmpty, passwordValue.isNotEmpty else {
            outShowAlert.accept("Fill all fields")
            return
        }
        
        NetworkManager.shared.postAuth(username: userNameValue, password: passwordValue)
            .trackActivity(loading)
            .subscribe { [weak self] user in
                UserService.shared.user = user
                self?.outLoginTrigger.accept(())
            } onError: { errorMessage in
                print(errorMessage)
            }
            .disposed(by: disposeBag)
    }
}
