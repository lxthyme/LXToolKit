//
//  ModalSize.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

enum ModalSize {
    case `default`, half, full
    case fluid(percentage: Float)
    case sideMargin(value: Float)
    case custom(size: Float)
    case customOrientation(sizePortrait: Float, sizeLandscape: Float)

    func calculateWidth(_ parentSize: CGSize) -> Float {
        switch self {
        case .default:
            return floorf(Float(parentSize.width) - (PresentrConstants.Values.defaultSideMargin * 2.0))
        case .half:
            return floorf(Float(parentSize.width) / 2.0)
        case .full:
            return Float(parentSize.width)
        case .custom(let size):
            return size
        case .customOrientation(let sizePortrait, let sizeLandscape):
            switch UIDevice.current.orientation {
            case .portrait, .portraitUpsideDown:
                return min(Float(UIScreen.main.bounds.width), sizePortrait)
            case .landscapeLeft, .landscapeRight:
                return min(Float(UIScreen.main.bounds.width), sizeLandscape)
            default:
                return min(Float(UIScreen.main.bounds.width), sizePortrait)
            }
        case .fluid(let percentage):
            return floorf(Float(parentSize.width) * percentage)
        case .sideMargin(let value):
            return floorf(Float(parentSize.width) - value * 2.0)
        }
    }

    func calculateHeight(_ parentSize: CGSize) -> Float {
        switch self {
        case .default:
            return floorf(Float(parentSize.height) * PresentrConstants.Values.defaultHeightPercentage)
        case .half:
            return floorf(Float(parentSize.height) / 2.0)
        case .full:
            return Float(parentSize.height)
        case .custom(let size):
            return size
        case .customOrientation(let sizePortrait, let sizeLandscape):
            switch UIDevice.current.orientation {
            case .portrait, .portraitUpsideDown:
                return min(Float(UIScreen.main.bounds.height), sizePortrait)
            case .landscapeLeft, .landscapeRight:
                return min(Float(UIScreen.main.bounds.height), sizeLandscape)
            default:
                return min(Float(UIScreen.main.bounds.height), sizePortrait)
            }
        case .fluid(let percentage):
            return floorf(Float(parentSize.height) * percentage)
        case .sideMargin(let value):
            return floorf(Float(parentSize.height) - value * 2)
        }
    }
}

// MARK: - ✈️Equatable
extension ModalSize: Equatable {}

// MARK: - ✈️CustomStringConvertible
extension ModalSize: CustomStringConvertible {
    var description: String {
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
