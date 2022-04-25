//
//  MainViewModel.swift
//  Storelink
//
//  Created by Акан Акиш on 18.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import RxCocoa
import RxSwift

final class MainViewModel: ViewModel, ViewModelType {
    struct Input {
        let loadDataTrigger: Observable<Void>
    }

    struct Output {
        let storageItems: Observable<[StorageItem]>
        let dataLoaded: Observable<Void>
    }

    let outStorageItems: BehaviorRelay<[StorageItem]> = .init(value: [])
    let outDataLoaded: PublishRelay<Void> = .init()

    func transform(input: Input) -> Output {
        input.loadDataTrigger
            .subscribe(onNext: { [weak self] in
                self?.loadData()
            })
            .disposed(by: disposeBag)

        return Output(storageItems: outStorageItems.asObservable(),
                      dataLoaded: outDataLoaded.asObservable())
    }

    func loadData() {
        NetworkManager.shared.getStorages()
            .trackActivity(loading)
            .subscribe { [weak self] storages in
                self?.outDataLoaded.accept(())
                self?.outStorageItems.accept(storages)
            } onError: { [weak self] error in
                self?.outDataLoaded.accept(())
                print(error)
            }
            .disposed(by: disposeBag)
    }
}

// outStorageItems.accept([
// StorageItem(id: 1, name: "Storage 1", description: "Storage 1 description", price: 120, size: 940, availableTime: "9:00 - 16:00", location: "Almaty, Kazakhstan", createdDate: "Today, 16:00", images: ["https://i2.wp.com/movingtips.wpengine.com/wp-content/uploads/2017/11/storage-units-white-doors.jpg?fit=1024%2C684&ssl=1", "https://cdn1.vogel.de/unsafe/840x1000/smart/images.vogel.de/vogelonline/bdb/1521100/1521149/original.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgawmD52cHLwGNoL-jwxm06B17gfq7C25FWQ&usqp=CAU"], type: "Storage"),
// StorageItem(id: 2, name: "Storage 2", description: "Storage 2 description", price: 90, size: 1000, availableTime: "9:00 - 18:00", location: "Almaty, Kazakhstan", createdDate: "Today, 18:00", images: ["https://postandparcel.info/wp-content/uploads/2016/02/selfstorage.jpg"], type: "Storage"),
// StorageItem(id: 3, name: "Storage 3", description: "Storage 3 description", price: 150, size: 400, availableTime: "14:00 - 19:00", location: "Nur-Sultan, Kazakhstan", createdDate: "Yesterday, 14:00", images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0zk2RqcvhfNfS5XQVSRvjdgDNP8nbuxspbQ&usqp=CAU"], type: "Storage")])
