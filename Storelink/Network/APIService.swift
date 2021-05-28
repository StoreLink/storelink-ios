//
//  APIService.swift
//  Storelink
//
//  Created by Акан Акиш on 17.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Moya

enum APIService {
    case getStorages
    case getItems
    case postStorage(request: StorageItemRequest)
    case postItem(request: ItemRequest)
    case postRegistration(request: RegistrationRequest)
    case postAuth(request: LoginRequest)
}

extension APIService: TargetType {
    
    // Localhost url
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }
    
    // Path of each operation that will be appended to base URL
    var path: String {
        switch self {
        case .getStorages:
            return "/storage"
        case .getItems:
            return "/item"
        case .postStorage:
            return "/storage/newStorage"
        case .postItem:
            return "/item/newItem"
        case .postRegistration:
            return "/auth/signup"
        case .postAuth:
            return "/auth/signin"
        }
    }
    
    // Specify which method our calls should use
    var method: Method {
        switch self {
        case .getStorages,
             .getItems:
            return .get
        case .postStorage,
             .postItem,
             .postRegistration,
             .postAuth:
            return .post
        }
    }
    
    // Request parameters
    var parameters: [String: Any]? {
        switch self {
        case .postStorage(let request):
            return request.parameters
        case .postItem(let request):
            return request.parameters
        case .postRegistration(let request):
            return request.parameters
        case .postAuth(let request):
            return request.parameters
        default:
            return [:]
        }
    }
    
    // Type of encoding
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getStorages,
             .getItems:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    // Specify body parameters, objects, files etc.
    // Plain request is a request without a body.
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
     // Headers that service requires. 
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    // Sample return mock data to test
    var sampleData: Data {
        return Data()
    }
}
