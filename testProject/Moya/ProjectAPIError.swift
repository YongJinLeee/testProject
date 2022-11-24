//
//  ProjectAPIError.swift
//  testProject
//
//  Created by YongJin on 2022/11/24.
//

import Foundation
import Moya

public enum ProjectAPIError: Error {
    case decodeError(Error)
    case failureError(MoyaError)
    case unknown

    var localizedDescription: String { return message() }

    func message() -> String {

        switch self {
        case .decodeError(let error):
            return error.localizedDescription
        case .failureError(let error):
            if let desc = error.errorDescription {
                return desc
            }
            return "failureError"
        case .unknown:
            return "unknown"
        }
    }
}
