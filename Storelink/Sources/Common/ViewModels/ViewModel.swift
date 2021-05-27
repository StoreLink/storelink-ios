//
//  ViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 17.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    let loading = ActivityIndicator()
}
