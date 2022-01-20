//
//  XLLanguageModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

private let languageKey = "CurrentLanguageKey"
class XLLanguageModel: NSObject, HandyJSON {
    var urlParam: String?
    var name: String?
    required override init() {}
     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< urlParam <-- "url_param"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

extension XLLanguageModel {
    func displayName() -> String {
        return (name.isNilOrEmpty == false ? name: urlParam) ?? ""
    }
    func save() {
        if let json = self.toJSONString() {
            UserDefaults.standard.set(json, forKey: languageKey)
        } else {
            Logger.error("Language can't be saved")
        }
    }

    static func currentLanguage() -> XLLanguageModel? {
        if let json = UserDefaults.standard.string(forKey: languageKey),
           let language = XLLanguageModel.deserialize(from: json) {
            return language
        }
        return nil
    }

    static func removeCurrentLanguage() {
        UserDefaults.standard.removeObject(forKey: languageKey)
    }
}

struct XLLanguagesModel: HandyJSON {
    var totalCount: Int = 0
    var totalSize: Int = 0
    var languages: [XLRepoLanguageModel] = []
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< totalCount <-- "total_count"
        mapper <<< totalSize <-- "total_size"
    }
}

struct XLRepoLanguageModel: HandyJSON {
    var size: Int = 0
    var name: String?
    var color: String?
}

struct XLLanguageLinesModel: HandyJSON {
    var language: String?
    var files: String?
    var lines: String?
    var blanks: String?
    var comments: String?
    var linesOfCode: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< linesOfCode <-- "lines_of_code"
    }
}
