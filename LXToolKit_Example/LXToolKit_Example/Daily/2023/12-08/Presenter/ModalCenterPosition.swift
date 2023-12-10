//
//  ModalCenterPosition.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

enum ModalCenterPosition {
    case center, topCenter, bottomCenter
    case custom(centerPoint: CGPoint)
    case customOrigin(origin: CGPoint)

    func calculateCenterPoint(_ containerFrame: CGRect) -> CGPoint? {
        switch self {
        case .center:
            return CGPoint(x: containerFrame.origin.x + (containerFrame.width / 2),
                           y: containerFrame.origin.y + (containerFrame.height / 2))
        case .topCenter:
            return CGPoint(x: containerFrame.origin.x + (containerFrame.width / 2),
                           y: containerFrame.origin.y + (containerFrame.height * (1 / 4) - 1))
        case .bottomCenter:
            return CGPoint(x: containerFrame.origin.x + (containerFrame.width / 2),
                           y: containerFrame.origin.y + (containerFrame.height * (3 / 4)))
        case .custom(let point):
            return point
        case .customOrigin(_):
            return nil
        }
    }

    func calculateOrigin() -> CGPoint? {
        switch self {
        case .customOrigin(let origin):
            return origin
        default:
            return nil
        }
    }
}

// MARK: - ✈️Equatable
extension ModalCenterPosition: Equatable {}
