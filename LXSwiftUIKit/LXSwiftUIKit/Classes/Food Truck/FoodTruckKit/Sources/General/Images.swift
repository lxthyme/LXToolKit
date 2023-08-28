//
//  Images.swift
//  
//
//  Created by lxthyme on 2023/8/25.
//

import SwiftUI

// MARK: - 👀
public extension Image {
    static var donutSymbol: Image {
        Image("donut", bundle: .module)
    }

    static func flavorSymbol(_ flavor: Flavor) -> Image {
        switch flavor {
        case .salty:
            return Image("salty", bundle: .module)
        case .sweet:
            return Image("sweet", bundle: .module)
        case .bitter:
            return Image("bitter", bundle: .module)
        case .sour:
            return Image("sour", bundle: .module)
        case .savory:
            return Image(systemName: "face.smiling")
        case .spicy:
            return Image("spicy", bundle: .module)
        }
    }
}
