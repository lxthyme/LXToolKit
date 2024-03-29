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

    public var title: String {
        switch self {
        case .main:
            return "main"
        case .section(let title):
            return title
        }
    }
}

// MARK: - 👀
extension LXSection: Equatable {}

// MARK: - 👀
extension LXSection: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .main:
            hasher.combine(".main")
        case .section(let title):
            hasher.combine(".section(\(title)")
        }
    }
}
public typealias LXOutlineItem = LXSectionOpt<String>

public struct LXSectionOpt<Item> {
    // associatedtype Item
    public let opt: LXOutlineOpt
    // public let section: LXSection
    public let scene: Navigator.Scene?
    public var subitems: [LXSectionOpt<Item>]? = nil
    public var isExpanded: Bool = false
    public let data: Item
    public init(// section: LXSection,
                opt: LXOutlineOpt,
                scene: Navigator.Scene? = nil,
                subitems: [LXSectionOpt<Item>]? = nil,
                isExpanded: Bool = false,
                data: Item = "") {
        // self.section = section
        self.scene = scene
        self.opt = opt
        self.subitems = subitems
        self.isExpanded = isExpanded
        self.data = data
    }
    // public func insert(_ item: LXSectionOpt) {}
}

// MARK: - 👀
extension LXSectionOpt: CustomStringConvertible {
    public var description: String {
        var desc = ""
        switch opt {
        case .outline(let section):
            desc += ".outline(\(section.title))"
        case .subitem(let section):
            desc += ".subitem(\(section.title))"
        }
        return desc
    }
}
// MARK: - 👀
extension LXSectionOpt: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(opt.hashValue)
    }
    public static func == (lhs: LXSectionOpt<Item>, rhs: LXSectionOpt<Item>) -> Bool {
        return lhs.opt == rhs.opt
    }
}

public enum LXOutlineOpt {
    // case outline(_ section: LXSection, scene: Navigator.Scene? = nil, subitems: [LXOutlineOpt])
    // case subitem(_ section: LXSection, scene: Navigator.Scene? = nil)
    case outline(_ section: LXSection)
    case subitem(_ section: LXSection)

    public var section: LXSection {
        switch self {
        case .outline(let section), .subitem(let section):
            return section
        }
    }
    // public var subitems: [LXOutlineOpt]? {
    //     switch self {
    //     case .outline(_, _, let subitems):
    //         return subitems
    //     case .subitem:
    //         return nil
    //     }
    // }
    // public var scene: Navigator.Scene? {
    //     switch self {
    //     case .outline(_, let scene, _):
    //         return scene
    //     case .subitem(_, let scene):
    //         return scene
    //     }
    // }
}

// MARK: - 👀
extension LXOutlineOpt: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .outline(let section):
            hasher.combine("\(section.title)")
        case .subitem(let section):
            hasher.combine("\(section.title)")
        }
    }
    public static func == (lhs: LXOutlineOpt, rhs: LXOutlineOpt) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

// MARK: - 👀
public extension Array where Element == LXOutlineItem {
    func xl_first(where predicate: (LXOutlineItem) throws -> Bool) throws -> LXOutlineItem? {
        for item in self {
            if let result = try? item.xl_first(where: predicate) {
                return result
            }
        }
        return nil
    }
}

// MARK: - 👀
// public extension Array where Element == LXOutlineOpt {
//     func xl_first(where predicate: (LXOutlineOpt) throws -> Bool) throws -> LXOutlineOpt? {
//         for item in self {
//             if let result = try? item.xl_first(where: predicate) {
//                 return result
//             }
//         }
//         return nil
//     }
// }

// MARK: - 👀
public extension LXSectionOpt {
    func xl_first(where predicate: (LXSectionOpt) throws -> Bool) throws -> LXSectionOpt {
        func first2(from opt: LXSectionOpt, where predicate: (LXSectionOpt) throws -> Bool) throws -> LXSectionOpt? {
            switch opt.opt {
            case .outline:
                if try predicate(opt) {
                    return opt
                }
                for tmp in opt.subitems ?? [] {
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
// public extension LXOutlineOpt {
//     func xl_first(where predicate: (LXOutlineOpt) throws -> Bool) throws -> LXOutlineOpt {
//         func first2(from opt: LXOutlineOpt, where predicate: (LXOutlineOpt) throws -> Bool) throws -> LXOutlineOpt? {
//             switch opt {
//             case .outline(_, _, let subitems):
//                 if try predicate(opt) {
//                     return opt
//                 }
//                 for tmp in subitems {
//                     if let item = try first2(from: tmp, where: predicate) {
//                         return item
//                     }
//                 }
//             case .subitem:
//                 if try predicate(opt) {
//                     return opt
//                 }
//             }
//             return nil
//         }
//         if let item = try first2(from: self, where: predicate) {
//             return item
//         }
//         throw "Error[1.]: Not Found!"
//     }
// }

// MARK: - 👀
extension LXOutlineOpt: CustomStringConvertible {
    public var description: String {
        switch self {
        case .outline(let section):
            return ".outline(\(section.title))"
        case .subitem(let section):
            return ".subitem(\(section.title))"
        }
    }
}
