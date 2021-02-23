//
//  MainViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 18.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import RxSwift
import RxCocoa

final class MainViewModel: ViewModel, ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let storageItems: Observable<[StorageItem]>
    }
    
    let outStorageItems: BehaviorRelay<[StorageItem]> = .init(value: [])
    
    func transform(input: Input) -> Output {
        outStorageItems.accept([StorageItem(title: "Storage 1", description: "Storage description", location: "Almaty", price: 40000),
                                StorageItem(title: "Storage 2", description: "Storage description", location: "Almaty", price: 40000),
                                StorageItem(title: "Storage 3", description: "Storage description", location: "Almaty", price: 40000)])
        
        return Output(storageItems: outStorageItems.asObservable())
    }
}
