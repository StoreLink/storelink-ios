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
    case postStorage(request: StorageItemRequest)
    case postRegistration(request: UserRequest)
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
        case .postStorage:
            return "/storage/newStorage"
        case .postRegistration:
            return "/auth/signup"
        }
    }
    
    // Specify which method our calls should use
    var method: Method {
        switch self {
        case .getStorages:
            return .get
        case .postStorage,
             .postRegistration:
            return .post
        }
    }
    
    // Request parameters
    var parameters: [String: Any]? {
        switch self {
        case .postStorage(let request):
            return request.parameters
        case .postRegistration(let request):
            return request.parameters
        default:
            return [:]
        }
    }
    
    // Type of encoding
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getStorages:
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
