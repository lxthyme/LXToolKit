//
//  namespace.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2020/11/17.
//

import Foundation
// WrapperType = BaseType
// WrappedType = BaseValue
// wrappedValue = baseValue
// MARK: - 🔥NamespaceWrappable
public protocol NamespaceWrappable {
    associatedtype BaseType
    var xl: BaseType { get }
    static var xl: BaseType.Type { get }
}

public extension NamespaceWrappable {
    var xl: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }

    static var xl: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public protocol TypeWrapperProtocol {
    associatedtype BaseValue
    var baseValue: BaseValue { get }
    init(value: BaseValue)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public var baseValue: T
    public init(value: T) {
        self.baseValue = value
    }
}

// MARK: - 🔥XLWrapper
//public final class XLWrapper<Base> {
//    public let base: Base
//    public init(_ base: Base) {
//        self.base = base
//    }
//}
//
//public protocol XLProtocol {
//    associatedtype XLType
//    var xl: XLType { get }
//    static var xl: XLType.Type { get }
//}
//// MARK: - 👀
//public extension XLProtocol {
//    public var xl: XLWrapper<Self> {
//        return XLWrapper(self)
//    }
//    public static var xl: XLWrapper<Self>.Type {
//        return XLWrapper<Self>.self
//    }
//}

// MARK: - 🔥Swifty
public struct Swifty<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
public protocol SwiftyCompatible {
    associatedtype SwiftyeBase

    static var xl: Swifty<SwiftyeBase>.Type { get set }
    var xl: Swifty<SwiftyeBase> { get set }
}
// MARK: - 👀
public extension SwiftyCompatible {
    static var xl: Swifty<Self>.Type {
        get {
            return Swifty<Self>.self
        }
        set { }
    }
    var xl: Swifty<Self> {
        get {
            return Swifty(self)
        }
        set { }
    }
}
extension NSObject: SwiftyCompatible {}
