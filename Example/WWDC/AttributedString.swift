//
//  AttributedString.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/6/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum RainbowAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    enum Value: String, Codable {
        case plain
        case fun
        case extreme
    }
    public static var name = "rainbow"
}

extension AttributeScopes {
    struct CaffeAppAttributes: AttributeScope {
        let rainbow: RainbowAttribute

        // let swiftUI: Swifui
    }

    var caffeApp: CaffeAppAttributes.Type { CaffeAppAttributes.self }
}

let header = AttributedString(localized: "^[Fast & Delicious](rainbow: 'extreme') Food", including: \.caffeApp)
