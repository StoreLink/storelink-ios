//
//  StorageDescriptionViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 23.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

final class StorageDescriptionViewModel: ViewModel, ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let storageItem: StorageItem
    
    init(storageItem: StorageItem) {
        self.storageItem = storageItem
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
