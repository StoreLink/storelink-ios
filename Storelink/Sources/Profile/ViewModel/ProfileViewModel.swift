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
        ProfileCellModel(name: "Персональная информация", image: Assets.personInfo.image),
        ProfileCellModel(name: "Методы оплаты", image: Assets.paymentCard.image),
        ProfileCellModel(name: "Уведомления", image: Assets.notification.image)])
    
}
