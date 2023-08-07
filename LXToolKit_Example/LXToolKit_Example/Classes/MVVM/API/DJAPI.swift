//
//  DJAPI.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import UIKit
// import RxSwift
// import Moya
// import SwifterSwift

protocol ProductApiType {
    var addXAuth: Bool { get }
}

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

enum DJAPI: LXToolKit.DJAPI {
    case download(url: URL, fileName: String?)
    
    case searchRepositories(query: String, sort: String, order: String, page: Int)

    case searchUsers(query: String, sort: String, order: String, page: Int)
}

// MARK: - 👀
extension DJAPI {
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var localLocation: URL {
        switch self {
        case .download(_, let fileName):
            if let fileName {
                return assetDir.appendingPathComponent(fileName)
            }
        default: break
        }
        return assetDir
    }

    var downloadDestination: DownloadDestination {
        return { _, _ in (self.localLocation, .removePreviousFile)}
    }
}

extension DJAPI: ProductApiType {
    var addXAuth: Bool {
        switch self {
        default: return true
        }
    }
}

extension DJAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .download(let url, _):
            return url
        default:
            return AppConfig.Network.githubBaseUrl.url!
        }
    }
    var path: String {
        switch self {
        case .download: return ""
        case .searchRepositories:
            return "/search/repositories"
        case .searchUsers:
            return "/search/users"
        }
    }
    var headers: [String : String]? {
        if let token = AuthManager.shared.token {
            switch token.type() {
            case .basic(let token):
                return ["Authorization": "Basic \(token)"]
            case .personal(let token):
                return ["Authorization": "token \(token)"]
            case .oAuth(let token):
                return ["Authorization": "token \(token)"]
            case .unauthorized: break
            }
        }
        return nil
    }
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .download: break
        case .searchRepositories(query: let query, sort: let sort, order: let order, page: let page):
            params["q"] = query
            params["sort"] = sort
            params["order"] = order
            params["page"] = page
        case .searchUsers(query: let query, sort: let sort, order: let order, page: let page):
            params["q"] = query
            params["sort"] = sort
            params["order"] = order
            params["page"] = page
        }
        return params
    }
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    var task: Task {
        switch self {
        case .download:
            return .downloadDestination(downloadDestination)
        default:
            if let parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    var sampleData: Data {
        var dataUrl: URL?
        switch self {
        case .download: break
        case .searchRepositories: dataUrl = R.file.repositorySearchJson()
        case .searchUsers: dataUrl = R.file.userSearchJson()
        }
        if let dataUrl,
           let data = try? Data(contentsOf: dataUrl) {
            return data
        }
        return Data()
    }
}
