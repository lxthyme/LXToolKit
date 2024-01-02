//
//  UIImage + forceLazyDecompression.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

// MARK: - 👀
extension UIImage {
    func forceLazyImageDecompression() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        self.draw(at: .zero)
        UIGraphicsEndImageContext()
        return self
    }
}
