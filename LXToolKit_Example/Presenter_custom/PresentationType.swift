//
//  PresentationType.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

enum PresentationType {
case alert, popup, topHalf, bottomHalf, fullScreen
    case dynamic(center: ModalCenterPosition)
    case custom(width: ModalSize, height: ModalSize, center: ModalCenterPosition)

    func size() -> (width: ModalSize, height: ModalSize)? {
        switch self {
        case .alert:
            return (.custom(size: 270), .custom(size: 180))
        case .popup:
            return (.default, .default)
        case .topHalf, .bottomHalf:
            return (.full, .half)
        case .fullScreen:
            return (.full, .full)
        case .dynamic(_):
            return nil
        case .custom(let width, let height, _):
            return (width, height)
        }
    }

    func position() -> ModalCenterPosition {
        switch self {
        case .alert, .popup:
            return .center
        case .topHalf:
            return .topCenter
        case .bottomHalf:
            return .bottomCenter
        case .fullScreen:
            return .center
        case .dynamic(let center):
            return center
        case .custom(_, _, let center):
            return center
        }
    }

    func defaultTransitionType() -> TransitionType {
        switch self {
        case .topHalf:
            return .coverVerticalFromTop
        default: return .coverVertical
        }
    }

    var shouldRoundCorners: Bool {
        switch self {
        case .alert, .popup:
            return true
        default: return false
        }
    }
}

// MARK: - ✈️CustomStringConvertible
extension PresentationType: CustomStringConvertible {
    var description: String {
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

// MARK: - ✈️Equatable
extension PresentationType: Equatable {
    static func == (lhs: PresentationType, rhs: PresentationType) -> Bool {
        switch (lhs, rhs) {
        case (let .custom(lhsWidth, lhsHeight, lhsCenter), let .custom(rhsWidth, rhsHeight, rhsCenter)):
            return lhsWidth == rhsWidth &&
            lhsHeight == rhsHeight &&
            lhsCenter == rhsCenter
        case (.alert, .alert): return true
        case (.popup, .popup): return true
        case (.topHalf, .topHalf): return true
        case (.bottomHalf, .bottomHalf): return true
        case (.dynamic, .dynamic): return true
        default: return false
        }
    }
}
