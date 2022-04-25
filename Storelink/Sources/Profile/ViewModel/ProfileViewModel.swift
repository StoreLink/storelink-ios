//
//  ProfileViewModel.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/24/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import RxCocoa
import RxSwift

final class ProfileViewModel: ViewModel, ViewModelType {
    struct Input {}

    struct Output {
        let profileItems: Observable<[ProfileCellModel]>
    }

    private let profileItems: BehaviorRelay<[ProfileCellModel]> = BehaviorRelay(value: [])

    func transform(input _: Input) -> Output {
        profileItems.accept([ProfileCellModel(name: Strings.personalInformation, image: Assets.personInfo.image),
                             ProfileCellModel(name: Strings.paymentMethods, image: Assets.paymentCard.image),
                             ProfileCellModel(name: Strings.notifications, image: Assets.notification.image)])
        return Output(profileItems: profileItems.asObservable())
    }
}
