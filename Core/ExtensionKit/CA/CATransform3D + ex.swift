//
//  CATransform3D + ex.swift
//  Action
//
//  Created by LXThyme Jason on 2021/2/23.
//

import Foundation
import GLKit

extension CATransform3D: NamespaceWrappable {}
// MARK: - 🔐
//public extension Swifty where Base == CATransform3D {
public extension TypeWrapperProtocol where BaseValue == CATransform3D {
    var convertToGLKMatrix4: GLKMatrix4 {
        let base = baseValue
        return GLKMatrix4Make(Float(base.m11), Float(base.m12), Float(base.m13), Float(base.m14),
                              Float(base.m21), Float(base.m22), Float(base.m23), Float(base.m24),
                              Float(base.m31), Float(base.m32), Float(base.m33), Float(base.m34),
                              Float(base.m41), Float(base.m42), Float(base.m43), Float(base.m44))
    }
}
