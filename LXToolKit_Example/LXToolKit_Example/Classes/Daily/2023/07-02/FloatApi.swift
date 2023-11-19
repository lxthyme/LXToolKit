//
//  FloatApi.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/16.
//

import Foundation
import Moya
import LXToolKit
import ObjectMapper

enum FloatApi {
    case testFloat(id: String)
}

// MARK: - 👀
extension FloatApi: APIService {
    
    var provider: LXNetworking<FloatApi> {
        return AppConfig.Network.useStaging
        ? LXNetworking<FloatApi>.stubbingNetworking()
        : LXNetworking<FloatApi>.defaultNetworking()
    }
    var baseURL: URL {
        return URL(string: AppConfig.Network.localHost)!
    }
    var parameter: APIParameter {
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

// MARK: - 👀
extension LXNetworking where U == FloatApi {
    func testFloat(id: String) -> Single<LXFloatTestModel> {
        return request(.testFloat(id: id))
            .mapBaseMapper(LXFloatTestModel.self)
            .asSingle()
    }
    func testFloatCodable(id: String) -> Single<LXCodableTestModel> {
        return request(.testFloat(id: id))
            .mapBaseCodable(LXCodableTestModel.self)
            .asSingle()
    }
}
