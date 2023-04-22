//
//  LXBaseAPI.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Moya

// protocol ProductApiType {
//     var addXAuth: Bool { get }
// }

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

protocol API: DJAllAPI {
    // MARK: - Authentication is optional
    func createAccessToken(clientId: String, clientSecret: String, code: String, redirectUri: String?, state: String?) -> Single<Token>

    func events(page: Int) -> Single<[Event]>
    func repositoryEvents(owner: String, repo: String, page: Int) -> Single<[Event]>
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
    func userPerformedEvents(username: String, page: Int) -> Single<[Event]>
    func organizationEvents(username: String, page: Int) -> Single<[Event]>

    // MARK: - Authentication is required
    func profile() -> Single<User>
}

enum LXBaseAPI {
    case events(page: Int)
    case repositoryEvents(owner: String, repo: String, page: Int)
    case userReceivedEvents(username: String, page: Int)
    case userPerformedEvents(username: String, page: Int)
    case organizationEvents(username: String, page: Int)
}

// MARK: - 👀
extension LXBaseAPI: LXTargetType {
    var parameters: LXAPIParameter {
        return LXAPIParameter(path: "", params: [:])
        // switch self {
        // case .events(let page):
        //     return LXAPIParameter(path: "/events",
        //                           params: [
        //                             "page": page
        //                           ])
        // case .repositoryEvents(let owner, let repo, let page):
        //     return LXAPIParameter(path: "/repos/\(owner)/\(repo)/events",
        //                           params: [
        //                             "page": page
        //                           ])
        // case .userReceivedEvents(let username, let page):
        //     return LXAPIParameter(path: "/users/\(username)/received_events",
        //                           params: [
        //                             "page": page
        //                           ])
        // case .userPerformedEvents(let username, let page):
        //     return LXAPIParameter(path: "/users/\(username)/events",
        //                           params: [
        //                             "page": page
        //                           ])
        // case .organizationEvents(let username, let page):
        //     return LXAPIParameter(path: "/orgs/\(username)/events",
        //                           params: [
        //                             "page": page
        //                           ])
        // }
    }


}
