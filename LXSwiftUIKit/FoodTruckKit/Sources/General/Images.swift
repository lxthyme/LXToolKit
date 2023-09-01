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
        Image("donut", bundle: .main)
    }

    static func flavorSymbol(_ flavor: Flavor) -> Image {
        switch flavor {
        case .salty:
            return Image("salty", bundle: .main)
        case .sweet:
            return Image("sweet", bundle: .main)
        case .bitter:
            return Image("bitter", bundle: .main)
        case .sour:
            return Image("sour", bundle: .main)
        case .savory:
            return Image(systemName: "face.smiling")
        case .spicy:
            return Image("spicy", bundle: .main)
        }
    }
}
