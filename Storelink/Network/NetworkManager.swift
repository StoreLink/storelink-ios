//
//  NetworkManager.swift
//  Storelink
//
//  Created by Акан Акиш on 17.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Moya
import RxSwift

protocol NetworkManagerProtocol {
    func getStorages() -> Single<[StorageItem]>
    func getItems() -> Single<[Item]>
    func postStorage(request: StorageItemRequest) -> Single<Void>
    func postItem(request: ItemRequest) -> Single<Void>
    func postRegistration(username: String, email: String, password: String) -> Single<RequestMessage>
    func postAuth(username: String, password: String) -> Single<User>
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()

    private let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])

    private init() {}

    func getStorages() -> Single<[StorageItem]> {
        return provider.rx
            .request(.getStorages)
            .filterSuccessfulStatusCodes()
            .map([StorageItem].self)
    }

    func getItems() -> Single<[Item]> {
        return provider.rx
            .request(.getItems)
            .filterSuccessfulStatusCodes()
            .map([Item].self)
    }

    func postStorage(request: StorageItemRequest) -> Single<Void> {
        return provider.rx
            .request(.postStorage(request: request))
            .filterSuccessfulStatusCodes()
            .map { _ in }
    }

    func postItem(request: ItemRequest) -> Single<Void> {
        return provider.rx
            .request(.postItem(request: request))
            .filterSuccessfulStatusCodes()
            .map { _ in }
    }

    func postRegistration(username: String, email: String, password: String) -> Single<RequestMessage> {
        let request = RegistrationRequest(username: username.lowercased(), email: email.lowercased(), password: password)
        return provider.rx
            .request(.postRegistration(request: request))
            .filterSuccessfulStatusCodes()
            .map(RequestMessage.self)
    }

    func postAuth(username: String, password: String) -> Single<User> {
        let request = LoginRequest(username: username.lowercased(), password: password)
        return provider.rx
            .request(.postAuth(request: request))
            .filterSuccessfulStatusCodes()
            .map(User.self)
    }
}
