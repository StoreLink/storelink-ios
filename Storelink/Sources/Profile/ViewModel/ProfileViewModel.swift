//
//  ProfileViewModel.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/24/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import RxSwift
import RxCocoa

final class ProfileViewModel {
    
    let profileItems: BehaviorRelay<[ProfileCellModel]> = BehaviorRelay(value: [
        ProfileCellModel(name: Strings.personalInformation, image: Assets.personInfo.image),
        ProfileCellModel(name: Strings.paymentMethods, image: Assets.paymentCard.image),
        ProfileCellModel(name: Strings.notifications, image: Assets.notification.image)
    ])
    
}
