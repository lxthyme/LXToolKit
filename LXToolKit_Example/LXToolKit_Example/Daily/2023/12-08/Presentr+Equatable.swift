//
//  Presentr+Equatable.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/11.
//

import Foundation
import Presentr

// MARK: - ✈️Equatable
extension TransitionType: Equatable {
    public static func == (lhs: TransitionType, rhs: TransitionType) -> Bool {
        switch (lhs, rhs) {
        case (.crossDissolve, .crossDissolve): return true
        case (.coverVertical, .coverVertical): return true
        case (.coverVerticalFromTop, .coverVerticalFromTop): return true
        case (.coverHorizontalFromRight, .coverHorizontalFromRight): return true
        case (.coverHorizontalFromLeft, .coverHorizontalFromLeft): return true
        case (.flipHorizontal, .flipHorizontal): return true
        case (.coverFromCorner(let lhsCorner), .coverFromCorner(let rhsCorner)): return lhsCorner == rhsCorner
        case (.custom(let lhsPresentrAnimation), .custom(let rhsPresentrAnimation)): return lhsPresentrAnimation == rhsPresentrAnimation
        default: return false
        }
    }
}

// MARK: - ✈️CustomStringConvertible
extension TransitionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .crossDissolve:
            return ".crossDissolve"
        case .coverVertical:
            return ".coverVertical"
        case .coverVerticalFromTop:
            return ".coverVerticalFromTop"
        case .coverHorizontalFromRight:
            return ".coverHorizontalFromRight"
        case .coverHorizontalFromLeft:
            return ".coverHorizontalFromLeft"
        case .flipHorizontal:
            return ".flipHorizontal"
        case .coverFromCorner(let corner):
            return ".coverFromCorner(\(corner))"
        case .custom(let presentrAnimation):
            return ".custom(\(presentrAnimation))"
        }
    }
}

// MARK: - ✈️Equatable
// extension ModalCenterPosition: Equatable {}

// MARK: - ✈️CustomStringConvertible
extension ModalCenterPosition: CustomStringConvertible {
    public var description: String {
        switch self {
        case .center:
            return ".center"
        case .topCenter:
            return ".topCenter"
        case .bottomCenter:
            return ".bottomCenter"
        case .custom(let centerPoint):
            return ".custom(\(centerPoint))"
        case .customOrigin(let origin):
            return ".customOrigin(\(origin))"
        }
    }
}

// MARK: - ✈️Equatable
// extension ModalSize: Equatable {}

// MARK: - ✈️CustomStringConvertible
extension ModalSize: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default:
            return ".default"
        case .half:
            return ".half"
        case .full:
            return ".full"
        case .fluid(let percentage):
            return ".fluid(\(percentage))"
        case .sideMargin(let value):
            return ".sideMargin(\(value))"
        case .custom(let size):
            return ".custom(\(size))"
        case .customOrientation(let sizePortrait, let sizeLandscape):
            return ".customOrientation(\(sizePortrait), \(sizeLandscape))"
        }
    }
}

// MARK: - ✈️Equatable
// extension PresentationType: Equatable {
//     static func == (lhs: PresentationType, rhs: PresentationType) -> Bool {
//         switch (lhs, rhs) {
//         case (.alert, .alert): return true
//         case (.popup, .popup): return true
//         case (.topHalf, .topHalf): return true
//         case (.bottomHalf, .bottomHalf): return true
//         case (.dynamic, .dynamic): return true
//         case (let .custom(lhsWidth, lhsHeight, lhsCenter), let .custom(rhsWidth, rhsHeight, rhsCenter)):
//             return lhsWidth == rhsWidth &&
//             lhsHeight == rhsHeight &&
//             lhsCenter == rhsCenter
//         default: return false
//         }
//     }
// }

// MARK: - ✈️CustomStringConvertible
extension PresentationType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .alert:
            return ".alert"
        case .popup:
            return ".popup"
        case .topHalf:
            return ".topHalf"
        case .bottomHalf:
            return ".bottomHalf"
        case .fullScreen:
            return ".fullScreen"
        case .dynamic(let center):
            return ".dynamic(\(center))"
        case .custom(let width, let height, let center):
            return ".custom(width: \(width), height: \(height), center: \(center)"
        }
    }
}
