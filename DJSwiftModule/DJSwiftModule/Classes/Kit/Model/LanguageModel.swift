//
//  LanguageModel.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import HandyJSON

private let languageKey = "CurrentLanguageKey"

public struct LanguageModel: HandyJSON {
    var urlParam: String?
    var name: String?
    // MARK: 🛠Life Cycle
    public init() {}
    func displayName() -> String {
        return (name.isNilOrEmpty == false ? name: urlParam) ?? ""
    }
}

extension LanguageModel {

    func save() {
        if let json = self.toJSONString() {
            UserDefaults.standard.set(json, forKey: languageKey)
        } else {
            logError("Language can't be saved")
        }
    }

    static func currentLanguage() -> LanguageModel? {
        if let json = UserDefaults.standard.string(forKey: languageKey),
           let language = LanguageModel.deserialize(from: json) {
            return language
        }
        return nil
    }

    static func removeCurrentLanguage() {
        UserDefaults.standard.removeObject(forKey: languageKey)
    }
}

extension LanguageModel: Equatable {
    public static func == (lhs: LanguageModel, rhs: LanguageModel) -> Bool {
        return lhs.urlParam == rhs.urlParam
    }
}

struct LanguagesModel: HandyJSON {
    var totalCount: Int = 0
    var totalSize: Int = 0
    var languages: [RepoLanguageModel] = []
}

extension LanguagesModel {
    init(graph: RepositoryQuery.Data.Repository.Language?) {
        totalCount = graph?.totalCount ?? 0
        totalSize = graph?.totalSize ?? 0
        languages = (graph?.edges?.map { RepoLanguageModel(graph: $0) } ?? [])
        languages.sort { (lhs, rhs) -> Bool in
            lhs.size > rhs.size
        }
    }
}

struct RepoLanguageModel: HandyJSON {
    var size: Int = 0
    var name: String?
    var color: String?
}

extension RepoLanguageModel {
    init(graph: RepositoryQuery.Data.Repository.Language.Edge?) {
        size = graph?.size ?? 0
        name = graph?.node.name
        color = graph?.node.color
    }
}

struct LanguageLinesModel: HandyJSON {
    var language: String?
    var files: Int?
    var lines: Int?
    var blanks: Int?
    var comments: Int?
    var linesOfCode: Int?
}
