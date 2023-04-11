//
//  ApiError.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation

enum ApiError: Error {
    case serverError(response: ErrorResponse)

    var title: String {
        switch self {
        case .serverError(let response): return response.message ?? ""
        }
    }

    var description: String {
        switch self {
        case .serverError(let response): return response.detail()
        }
    }
}
