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
        let storageAdded: Observable<Void>
    }
    
    private let nameValue: BehaviorRelay<String?> = .init(value: nil)
    private let descriptionValue: BehaviorRelay<String?> = .init(value: nil)
    private let priceValue: BehaviorRelay<Int?> = .init(value: nil)
    private let sizeValue: BehaviorRelay<Int?> = .init(value: nil)
    private let storageTypeValue: BehaviorRelay<String?> = .init(value: nil)
    private let outStorageAdded: PublishRelay<Void> = .init()
    
    func transform(input: Input) -> Output {
        input.actionButtonTrigger
            .subscribe(onNext: { [weak self] in
                guard let name = self?.nameValue.value,
                    let description = self?.descriptionValue.value,
                    let price = self?.priceValue.value,
                    let size = self?.sizeValue.value,
                    let storageType = self?.storageTypeValue.value else { return }
                
                let request = StorageItemRequest(name: name, description: description, price: price, size: size, availableTime: "", location: nil, images: nil)
                self?.postRequest(request: request)
            })
            .disposed(by: disposeBag)
        
        input.nameValue
            .bind(to: nameValue)
            .disposed(by: disposeBag)
        
        input.descriptionValue
            .bind(to: descriptionValue)
            .disposed(by: disposeBag)
        
        input.priceValue
            .map { Int($0) }
            .bind(to: priceValue)
            .disposed(by: disposeBag)
        
        input.sizeValue
            .map { Int($0) }
            .bind(to: sizeValue)
            .disposed(by: disposeBag)
        
        input.storageTypeValue
            .bind(to: storageTypeValue)
            .disposed(by: disposeBag)
        
        return Output(storageAdded: outStorageAdded.asObservable())
    }
    
    func postRequest(request: StorageItemRequest) {
        NetworkManager.shared.postStorage(request: request)
        .subscribe(onSuccess: { [weak self] in
            self?.outStorageAdded.accept(())
        }, onError: { error in
            print("error")
        })
        .disposed(by: disposeBag)
    }
}
