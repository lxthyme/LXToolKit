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
public enum LXOutlineOpt: Hashable {
    case outline(title: String, subitems: [LXOutlineOpt])
    case subitem(title: String, vc: Navigator.Scene)
}
