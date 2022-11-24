//
//  ProjectAPI.swift
//  testProject
//
//  Created by YongJin on 2022/11/24.
//

import Foundation
import Moya

public enum ProjectAPI {
    
    case initialization
    case pagination(params: [String: Any])
}

extension ProjectAPI: TargetType {
    public var baseURL: URL {
        
        guard let url = URL(string:"http://d2bab9i9pr8lds.cloudfront.net" ) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    public var path: String {
        switch self {
            
        case .initialization:
            return "/api/home"
        case .pagination:
            return "/api/home/goods"
        }
    }
    
    public var method: Moya.Method {
        switch self {
            
        default:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
            
        case .initialization:
            return .requestPlain
        case let .pagination(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return NetworkAPI.headers
    }
    
}
