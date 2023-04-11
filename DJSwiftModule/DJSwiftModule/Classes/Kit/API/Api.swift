//
//  Api.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import UIKit
// import RxSwift

public protocol DJAllAPI {
    func downloadString(url: URL) -> Single<String>
    func searchRepositories(query: String, sort: String, order: String, page: Int, endCursor: String?) -> Single<RepositorySearchModel>
    func searchUsers(query: String, sort: String, order: String, page: Int, endCursor: String?) -> Single<UserSearchModel>

    // MARK: - Trending
    func trendingRepositories(language: String, since: String) -> Single<[TrendingRepositoryModel]>
    func trendingDevelopers(language: String, since: String) -> Single<[TrendingUserModel]>
    func languages() -> Single<[LanguageModel]>
}

class Api: NSObject {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    override init() {
        super.init()
    }
}

// MARK: 👀Public Actions
extension Api {}

// MARK: 🔐Private Actions
private extension Api {}
