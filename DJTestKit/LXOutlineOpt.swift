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
}
public enum LXOutlineOpt {
    case outline(title: String, subitems: [LXOutlineOpt], uuid: UUID = UUID())
    case subitem(title: String, scene: Navigator.Scene, uuid: UUID = UUID())

    public var title: String {
        switch self {
        case .outline(let title, _, _), .subitem(let title, _, _):
            return title
        }
    }
    public var subitems: [LXOutlineOpt]? {
        switch self {
        case .outline(_, let subitems, _):
            return subitems
        case .subitem(let title, _, _):
            return nil
        }
    }
    public var scene: Navigator.Scene? {
        switch self {
        case .outline:
            return nil
        case .subitem(_, let scene, _):
            return scene
        }
    }
}

// MARK: - 👀
extension LXOutlineOpt: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .outline(let title, let subitems, let uuid):
            hasher.combine("[outline]\(title)_\(uuid)")
        case .subitem(let title, let vc, let uuid):
            hasher.combine("[subitem]\(title)_\(uuid)")
        }
    }
    public static func == (lhs: LXOutlineOpt, rhs: LXOutlineOpt) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
