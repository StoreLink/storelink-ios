//
//  NetworkManager.swift
//  Storelink
//
//  Created by Акан Акиш on 17.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import RxSwift
import Moya

protocol NetworkManagerProtocol {
    func getStorages() -> Single<[StorageItem]>
    func postStorage(request: StorageItemRequest) -> Single<Void>
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
    
    func postStorage(request: StorageItemRequest) -> Single<Void> {
        return provider.rx
            .request(.postStorage(request: request))
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
