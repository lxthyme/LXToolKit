//
//  UIFont + ex.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum LXFontType: String {
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case bold = "Bold"
    case semibold = "Semibold"
}

// MARK: - 👀PingFangSC Font
extension UIFont {
    convenience init?(PingFang size: CGFloat, type: LXFontType = .regular) {
        self.init(name: "PingFangSC-\(type.rawValue)", size: size)
    }
    convenience init?(CorsivaHebrew size: CGFloat, type: LXFontType) {
        self.init(name: "CorsivaHebrew-\(type.rawValue)", size: size)
    }
}
