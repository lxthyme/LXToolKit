//
//  FloatApi.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/16.
//

import Foundation
import Moya
import LXToolKit

enum FloatApi: LXToolKit.DJAPI {
    case testFloat(id: String)
}

// MARK: - 👀
extension FloatApi: APIService {
    var baseURL: URL {
        return URL(string: AppConfig.Network.localHost)!
    }
    var parameter: LXToolKit.APIParameter {
        var params: [String: Any] = [:]
        switch self {
        case .testFloat(let id):
            params["id"] = id
            return APIParameter(path: "/api/lxthyme/testFloat", params: params, method: .post)
        }
    }
}
// MARK: - 👀
extension FloatApi: ProductApiType {
    var addXAuth: Bool {
        return true
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        Data(self.utf8)
    }
}
