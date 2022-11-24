//
//  NetworkAPI.swift
//  testProject
//
//  Created by YongJin on 2022/11/24.
//

import Foundation

struct NetworkAPI {
    
    static var headers: Dictionary<String, String> {
        let headers: Dictionary<String, String> = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
        return headers
    }

    static func stubbedResponse(_ filename: String) -> Data! {

        @objc class TestClass: NSObject {}
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}
