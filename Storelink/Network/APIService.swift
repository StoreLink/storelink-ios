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
        }
    }
    
    // Specify which method our calls should use
    var method: Method {
        switch self {
        case .getStorages:
            return .get
        }
    }
    
    // Specify body parameters, objects, files etc.
    // Plain request is a request without a body.
    var task: Task {
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
