//
//  LXOutlineOpt.swift
//  DJTestKit
//
//  Created by lxthyme on 2023/11/21.
//

import Foundation
import LXToolKit

public enum LXSection {
    case main
    case section(title: String)

    var title: String {
        switch self {
        case .main:
            return "main"
        case .section(let title):
            return title
        }
    }
}
public enum LXOutlineOpt {
    case outline(_ section: LXSection, scene: Navigator.Scene? = nil, subitems: [LXOutlineOpt], uuid: UUID = UUID())
    case subitem(_ section: LXSection, scene: Navigator.Scene? = nil, uuid: UUID = UUID())

    public var title: String {
        switch self {
        case .outline(let section, _, _, _), .subitem(let section, _, _):
            return section.title
        }
    }
    public var subitems: [LXOutlineOpt]? {
        switch self {
        case .outline(_, _, let subitems, _):
            return subitems
        case .subitem(_, _, _):
            return nil
        }
    }
    public var scene: Navigator.Scene? {
        switch self {
        case .outline(_, let scene, _, _):
            return scene
        case .subitem(_, let scene, _):
            return scene
        }
    }
}

// MARK: - 👀
extension LXOutlineOpt: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .outline(let section, _, let subitems, let uuid):
            hasher.combine("[outline]\(section.title)_\(uuid)")
        case .subitem(let section, let vc, let uuid):
            hasher.combine("[subitem]\(section.title)_\(uuid)")
        }
    }
    public static func == (lhs: LXOutlineOpt, rhs: LXOutlineOpt) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

// MARK: - 👀
public extension LXOutlineOpt {
    func xl_first(where predicate: (LXOutlineOpt) throws -> Bool) throws -> LXOutlineOpt {
        func first2(from opt: LXOutlineOpt, where predicate: (LXOutlineOpt) throws -> Bool) throws -> LXOutlineOpt? {
            switch opt {
            case .outline(_, _, let subitems, _):
                if try predicate(opt) {
                    return opt
                }
                for tmp in subitems {
                    if let item = try first2(from: tmp, where: predicate) {
                        return item
                    }
                }
            case .subitem:
                if try predicate(opt) {
                    return opt
                }
            }
            return nil
        }
        if let item = try first2(from: self, where: predicate) {
            return item
        }
        throw "Error[1.]: Not Found!"
    }
}

// MARK: - 👀
extension LXOutlineOpt: CustomStringConvertible {
    public var description: String {
        switch self {
        case .outline(let section, let scene, let subitems, let uuid):
            return ".outline(\(section.title), scene: \(scene?.description ?? ""), subitems: \(subitems))"
        case .subitem(let section, let scene, let uuid):
            return ".subitem(\(section.title), scene: \(scene?.description ?? ""))"
        }
    }
}
