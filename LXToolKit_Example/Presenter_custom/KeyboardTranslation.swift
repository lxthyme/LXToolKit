//
//  KeyboardTranslation.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

enum KeyboardTranslationType {
    case none, moveUp, compress, stickToTop

    public func getTranslationFrame(keyboardFrame: CGRect, presentedFrame: CGRect) -> CGRect {
        let keyboardTop = UIScreen.main.bounds.height - keyboardFrame.size.height
        let buffer: CGFloat = (presentedFrame.origin.y + presentedFrame.size.height == UIScreen.main.bounds.height) ? 0 : 20.0 // add a 20 pt buffer except when the presentedFrame is stick to bottom
        let presentedViewBottom = presentedFrame.origin.y + presentedFrame.height + buffer
        let offset = presentedViewBottom - keyboardTop
        switch self {
        case .moveUp:
            if offset > 0.0 {
                let frame = CGRect(x: presentedFrame.origin.x, y: presentedFrame.origin.y-offset, width: presentedFrame.size.width, height: presentedFrame.size.height)
                return frame
            }
            return presentedFrame
        case .compress:
            if offset > 0.0 {
                let y = max(presentedFrame.origin.y-offset, 20.0)
                let newHeight = y != 20.0 ? presentedFrame.size.height : keyboardTop - 40.0
                let frame = CGRect(x: presentedFrame.origin.x, y: y, width: presentedFrame.size.width, height: newHeight)
                return frame
            }
            return presentedFrame
        case .stickToTop:
            if offset > 0.0 {
                let y = max(presentedFrame.origin.y-offset, 20.0)
                let frame = CGRect(x: presentedFrame.origin.x, y: y, width: presentedFrame.size.width, height: presentedFrame.size.height)
                return frame
            }
            return presentedFrame
        case .none:
            return presentedFrame
        }
    }
}

// MARK: - 👀
extension Notification {
    func keyboardEndFrame() -> CGRect? {
        #if swift(>=4.2)
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        #else
        let frameKey = UIKeyboardFrameEndUserInfoKey
        #endif

        return (self.userInfo?[frameKey] as? NSValue)?.cgRectValue
    }

    func keyboardAnimationDuration() -> Double? {
        #if swift(>=4.2)
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        #else
        let durationKey = UIKeyboardAnimationDurationUserInfoKey
        #endif

        return (self.userInfo?[durationKey] as? NSNumber)?.doubleValue
    }
}
