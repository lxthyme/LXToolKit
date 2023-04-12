//
//  TrendingGithubAPI.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//

import Foundation
import Moya

enum TrendingGithubAPI {
    case trendingRespositories(language: String, since: String)
    case trendingDevelopers(language: String, since: String)
    case languages
}

extension TrendingGithubAPI: TargetType, ProductApiType {
    var baseURL: URL {
        return AppConfig.Network.trendingGithubBaseUrl.url!
    }
    var path: String {
        switch self {
        case .trendingRespositories:
            return "/repositories"
        case .trendingDevelopers:
            return "/developers"
        case .languages:
            return "/languages"
        }
    }
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    var headers: [String : String]? {
        return nil
    }
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .trendingRespositories(let language, let since),
                .trendingDevelopers(let language, let since):
            params["language"] = language
            params["since"] = since
        default: break
        }
        return params
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var sampleData: Data {
        var dataUrl: URL?
        switch self {
        case .trendingRespositories:
            dataUrl = R.file.repositoryTrendingsJson()
        case .trendingDevelopers:
            dataUrl = R.file.userTrendingsJson()
        case .languages:
            dataUrl = R.file.languagesJson()
        }
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
    }
    var task: Task {
        if let parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    var addXAuth: Bool {
        switch self {
        default: return false
        }
    }
}
