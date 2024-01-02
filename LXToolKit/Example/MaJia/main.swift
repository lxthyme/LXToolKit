//
//  main.swift
//  MaJia
//
//  Created by LXThyme Jason on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

private struct LXConfig {
    static let pwd = "/Users/lxthyme/Desktop/Lucky/Git/vfamily"
    static let xcodeproj = "Soul.xcodeproj"
    static let oldProjectName = "Soul"
    static let newProjectName = "VaffleFervour"
    static let oldClsPrefix = "WOL"
    static let newClsPrefix = "GSF"
    static let addMockCode = true
    static let excludeDir = [""]

    static let shouldInsertSampleCode = false
    static let shouldDeleteComments = true
    static let shouldHandleAssets = true

    static var xcodeprojPath = ""
}

private let fm = FileManager.default

func main() {
    var isDirectory: ObjCBool = false

    guard !fm.fileExists(atPath: LXConfig.pwd, isDirectory: &isDirectory) else {
        print("\(LXConfig.pwd) 不存在!")
        return
    }
    guard !isDirectory.boolValue else {
        print("\(LXConfig.pwd) 不是目录!")
        return
    }

    let projectPath = LXConfig.pwd.appending(LXConfig.xcodeproj)
    let xcodeprojPath = projectPath.appending("project.pbxproj")
    guard fm.fileExists(atPath: projectPath, isDirectory: &isDirectory),
       isDirectory.boolValue,
       fm.fileExists(atPath: xcodeprojPath, isDirectory: &isDirectory),
       !isDirectory.boolValue else {
        print("修改类名前缀参数配置错误! >>>\(xcodeprojPath)")
        return
    }
    LXConfig.xcodeprojPath = xcodeprojPath

    if LXConfig.shouldInsertSampleCode {
        // FIXME: 添加无用代码
        print("添加无用代码!")
    }

    if LXConfig.shouldHandleAssets {
        // FIXME: 修改 Assets 中资源的 md5
        print("修改 Assets 中资源的 md5 完成!")
    }

    if LXConfig.shouldDeleteComments {
        // FIXME: 删除注释和空行
        print("删除注释和空行完成!")
    }

    if !LXConfig.oldProjectName.isEmpty,
          !LXConfig.newProjectName.isEmpty {
            // FIXME: 修改工程名
            print("修改工程名完成!")
    }

    if LXConfig.oldClsPrefix.isEmpty,
       !LXConfig.newClsPrefix.isEmpty,
       var xcodeprojContent = try? String(contentsOfFile: LXConfig.xcodeprojPath, encoding: .utf8) {
        // FIXME: 修改工程名
        print("修改类名前缀完成!")
//        LXMaJia.modifyClassPrefix(xcodeprojContent: &xcodeprojContent, pwd: LXConfig.pwd, oldPrefix: LXConfig.oldClsPrefix, newPrefix: LXConfig.newClsPrefix, excludeDir: LXConfig.excludeDir)

    } else {
        print("修改类名前缀 skipping!")
    }

    // FIXME: if (outDirString)

}
