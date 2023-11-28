//
//  AttributedString.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/6/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 15, *)
enum RainbowAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    enum Value: String, Codable {
        case plain
        case fun
        case extreme
    }
    public static var name = "rainbow"
}

@available(iOS 15, *)
extension AttributeScopes {
    struct CaffeAppAttributes: AttributeScope {
        let rainbow: RainbowAttribute

        // let swiftUI: Swifui
    }

    var caffeApp: CaffeAppAttributes.Type { CaffeAppAttributes.self }
}

@available(iOS 15, *)
let header = AttributedString(localized: "^[Fast & Delicious](rainbow: 'extreme') Food", including: \.caffeApp)
