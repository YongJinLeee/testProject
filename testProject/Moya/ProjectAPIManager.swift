//
//  ProjectAPIManager.swift
//  testProject
//
//  Created by YongJin on 2022/11/24.
//

import Foundation
import Moya

final class ReloadIgnoringLocalCacheDataCachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {

        var mutableRequest = request
        mutableRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        return mutableRequest
    }
}

public class ProjectAPIManager: NSObject {
    
    typealias failureClosure = (ProjectAPIError) -> Void
    
    var projectProvider: MoyaProvider<ProjectAPI>!
    
    private override init() {
        projectProvider = MoyaProvider<ProjectAPI>(plugins: [ReloadIgnoringLocalCacheDataCachePolicyPlugin()])
    }
    
    // MARK: Initialization API
    
    
    static func initialization(onSuccess success: @escaping (Initializing) -> Void, onFailure failure: @escaping failureClosure) {

        ProjectAPIManager().request(api: ProjectAPI.initialization, responseObject: Initializing.self, onSuccess: { (initDataDTO, data) in
            
        success(initDataDTO)
        }, onFailure: {(error) in
            failure(error)
        })
    }
    
    // MARK: Pagination API
    
    static func pagination(onSuccess success: @escaping (Pagination) -> Void, onFailure failure: @escaping failureClosure) {
        
        let parameters: [String : Any] = ["lastId" : 0]
        
        ProjectAPIManager().request(api: ProjectAPI.pagination(params: parameters), responseObject: Pagination.self, onSuccess: { (pageInfoDTO, data) in
            success(pageInfoDTO)
            
        }, onFailure: { (error) in
                failure(error) })
    }
    
}

extension ProjectAPIManager {
    
    // Moya 호출시 Response의 객체 타입을 제네릭 ResponseObject으로 변환 처리
    func request<ResponseObject: Decodable>(api: ProjectAPI, responseObject: ResponseObject.Type, onSuccess success: @escaping (ResponseObject, Data) -> Void, onFailure failure: @escaping (ProjectAPIError) -> Void) {

        // Moya request 호출
        projectProvider.request(api) { result in
            self.processResult(result: result, responseObject: responseObject, onSuccess: success, onFailure: failure)
        }
    }
    
    // Response의 객체 타입을 제네릭 ResponseObject으로 변환 처리
    func processResult<ResponseObject: Decodable>(result: Result<Moya.Response, Moya.MoyaError>, responseObject: ResponseObject.Type, onSuccess success: @escaping (ResponseObject, Data) -> Void, onFailure failure: @escaping (ProjectAPIError) -> Void) {

        switch result {
        case let .success(response):
            do {
                let resObject = try JSONDecoder().decode(responseObject, from: response.data)
                success(resObject, response.data)
            } catch let error {
                failure(.decodeError(error))
            }
        case let .failure(error):
            failure(.failureError(error))
        }
    }
    
}
