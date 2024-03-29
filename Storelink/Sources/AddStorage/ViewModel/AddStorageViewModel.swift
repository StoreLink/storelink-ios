//
//  AddStorageViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 20.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class AddStorageViewModel: ViewModel, ViewModelType {
    struct Input {
        let nameValue: Observable<String>
        let descriptionValue: Observable<String>
        let availableTimeValue: Observable<String>
        let priceValue: Observable<String>
        let sizeValue: Observable<String>
        let storageTypeValue: Observable<String>
        let imageValue: Observable<String>
        let coordinateValue: Observable<Coordinate>
        let actionButtonTrigger: Observable<Void>
    }

    struct Output {
        let storageAdded: Observable<Void>
    }

    private let nameValue: BehaviorRelay<String?> = .init(value: nil)
    private let descriptionValue: BehaviorRelay<String?> = .init(value: nil)
    private let availableTimeValue: BehaviorRelay<String?> = .init(value: nil)
    private let priceValue: BehaviorRelay<Int?> = .init(value: nil)
    private let sizeValue: BehaviorRelay<Double?> = .init(value: nil)
    private let storageTypeValue: BehaviorRelay<String?> = .init(value: nil)
    private let imageValue: BehaviorRelay<String?> = .init(value: nil)
    private let coordinate: BehaviorRelay<Coordinate?> = .init(value: nil)
    private let outStorageAdded: PublishRelay<Void> = .init()

    func transform(input: Input) -> Output {
        input.actionButtonTrigger
            .subscribe(onNext: { [weak self] in
                guard let name = self?.nameValue.value,
                      let description = self?.descriptionValue.value,
                      let availableTime = self?.availableTimeValue.value,
                      let price = self?.priceValue.value,
                      let size = self?.sizeValue.value,
                      let coordinate = self?.coordinate.value,
                      let image = self?.imageValue.value,
                      let storageType = self?.storageTypeValue.value else { return }

                let request = StorageItemRequest(name: name, description: description, availableTime: availableTime, price: price, size: size, longitude: coordinate.longitude, latitude: coordinate.latitude, image: image)
                self?.postRequest(request: request)
            })
            .disposed(by: disposeBag)

        input.nameValue
            .bind(to: nameValue)
            .disposed(by: disposeBag)

        input.descriptionValue
            .bind(to: descriptionValue)
            .disposed(by: disposeBag)

        input.availableTimeValue
            .bind(to: availableTimeValue)
            .disposed(by: disposeBag)

        input.priceValue
            .map { Int($0) }
            .bind(to: priceValue)
            .disposed(by: disposeBag)

        input.sizeValue
            .map { Double($0) }
            .bind(to: sizeValue)
            .disposed(by: disposeBag)

        input.storageTypeValue
            .bind(to: storageTypeValue)
            .disposed(by: disposeBag)

        input.imageValue
            .bind(to: imageValue)
            .disposed(by: disposeBag)

        input.coordinateValue
            .bind(to: coordinate)
            .disposed(by: disposeBag)

        return Output(storageAdded: outStorageAdded.asObservable())
    }

    func postRequest(request: StorageItemRequest) {
        NetworkManager.shared.postStorage(request: request)
            .trackActivity(loading)
            .subscribe { [weak self] in
                self?.outStorageAdded.accept(())
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}
