//
//  namespace.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2020/11/17.
//

// WrapperType = BaseType
// WrappedType = BaseValue
// wrappedValue = baseValue
// MARK: - 🔥NamespaceWrappable
public protocol NamespaceWrappable {
    associatedtype BaseType
    var xl: BaseType { get }
    static var XL: BaseType.Type { get }
}

public extension NamespaceWrappable {
    var xl: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }

    static var XL: NamespaceWrapper<Self>.Type {
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

/**
 Use `Swifty` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 // 1. Extend Swifty protocol with constrain on Base
 // Read as: Swifty Extension where Base is a SomeType
 extension Swifty where Base: SomeType {
 // 2. Put any specific swifty extension for SomeType here
 }

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 */

// MARK: - 🔥Swifty
public struct Swifty<Base> {
    /// Base object to extend.
    public var base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has swifty extensions.
public protocol SwiftyCompatible {
    /// Extended type
    associatedtype SwiftyeBase

    /// Swifty extensions.
    static var XL: Swifty<SwiftyeBase>.Type { get set }

    /// Swifty extensions.
    var xl: Swifty<SwiftyeBase> { get set }
}
// MARK: - 👀
public extension SwiftyCompatible {
    /// Swifty extensions.
    static var XL: Swifty<Self>.Type {
        get {
            return Swifty<Self>.self
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Swifty to "mutate" base type
        }
    }

    /// Swifty extensions.
    var xl: Swifty<Self> {
        get {
            return Swifty(self)
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Swifty to "mutate" base object
        }
    }
}
import class Foundation.NSObject
extension NSObject: SwiftyCompatible {}
