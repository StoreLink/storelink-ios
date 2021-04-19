//
//  AddStorageViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 20.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AddStorageViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let nameValue: Observable<String>
        let descriptionValue: Observable<String>
        let priceValue: Observable<String>
        let sizeValue: Observable<String>
        let storageTypeValue: Observable<String>
        let actionButtonTrigger: Observable<Void>
    }
    
    struct Output {
        
    }
    
    private let nameValue: BehaviorRelay<String?> = .init(value: nil)
    private let descriptionValue: BehaviorRelay<String?> = .init(value: nil)
    private let priceValue: BehaviorRelay<String?> = .init(value: nil)
    private let sizeValue: BehaviorRelay<String?> = .init(value: nil)
    private let storageTypeValue: BehaviorRelay<String?> = .init(value: nil)
    
    func transform(input: Input) -> Output {
        input.actionButtonTrigger
            .subscribe(onNext: { [weak self] in
                guard let name = self?.nameValue.value,
                    let description = self?.descriptionValue.value,
                    let price = self?.priceValue.value,
                    let size = self?.sizeValue.value,
                    let storageType = self?.storageTypeValue.value else { return}
            })
            .disposed(by: disposeBag)
        
        input.nameValue
            .bind(to: nameValue)
            .disposed(by: disposeBag)
        
        input.descriptionValue
            .bind(to: descriptionValue)
            .disposed(by: disposeBag)
        
        input.priceValue
            .bind(to: priceValue)
            .disposed(by: disposeBag)
        
        input.sizeValue
            .bind(to: sizeValue)
            .disposed(by: disposeBag)
        
        input.storageTypeValue
            .bind(to: storageTypeValue)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
