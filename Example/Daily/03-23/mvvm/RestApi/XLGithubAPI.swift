//
//  XLGithubAPI.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

protocol ProductAPIType {
    var addXAuth: Bool { get }
}

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

enum XLGithubAPI {
    case events(page: Int)
    case repositoryEvents(owner: String, repo: String, page: Int)
    case userReceivedEvents(username: String, page: Int)
    case userPerformedEvents(username: String, page: Int)
    case organizationEvents(username: String, page: Int)
}

extension XLGithubAPI: TargetType, ProductAPIType {
    var baseURL: URL {
        switch self {
//        case .download(let url, _):
//            return url
        default:
            return GlobalConfig.Network.githubBaseUrl.url!
        }
    }
    var cachedKey: String {
        var key = ""
        key.append(baseURL.absoluteString)
        key.append(path)
        let sortedKeyAndValues = parameters?.keys
            .sorted()
            .map({ "\($0)=\(parameters?[$0] ?? "")" })
            .joined(separator: "&")
        key.append(sortedKeyAndValues ?? "")
        return key
    }
    var path: String {
        switch self {
            case .events: return "/events"
            case .repositoryEvents(let owner, let repo, _): return "/repos/\(owner)/\(repo)/events"
            case .userReceivedEvents(let username, _): return "/users/\(username)/received_events"
            case .userPerformedEvents(let username, _): return "/users/\(username)/events"
            case .organizationEvents(let username, _): return "/orgs/\(username)/events"
        }
    }
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var headers: [String: String]? {
//        if let token = AuthManager.shared.token {
//            switch token.type() {
//            case .basic(let token):
//                return ["Authorization": "Basic \(token)"]
//            case .personal(let token):
//                return ["Authorization": "token \(token)"]
//            case .oAuth(let token):
//                return ["Authorization": "token \(token)"]
//            case .unauthorized: break
//            }
//        }
        return nil
    }
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
            case .events(let page):
                params["page"] = page
            case .repositoryEvents(_, _, let page):
                params["page"] = page
            case .userReceivedEvents(_, let page):
                params["page"] = page
            case .userPerformedEvents(_, let page):
                params["page"] = page
            case .organizationEvents(_, let page):
                params["page"] = page
            default: break
        }
        return params
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var localLocation: URL {
        switch self {
//        case .download(_, let fileName):
//            if let fileName = fileName {
//                return assetDir.appendingPathComponent(fileName)
//            }
        default: break
        }
        return assetDir
    }

    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, .removePreviousFile) }
    }

    public var task: Task {
        switch self {
//        case .download:
//            return .downloadDestination(downloadDestination)
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    var sampleData: Data {
        var dataUrl: URL?
        switch self {
        case .events: dataUrl = R.file.eventsJson()
        case .repositoryEvents: dataUrl = R.file.eventsRepositoryJson()
        case .userReceivedEvents: dataUrl = R.file.eventsUserReceivedJson()
        case .userPerformedEvents: dataUrl = R.file.eventsUserPerformedJson()
        case .organizationEvents: dataUrl = R.file.eventsOrganizationJson()
        }
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
    }
    var addXAuth: Bool {
        switch self {
        default: return true
        }
    }
}
