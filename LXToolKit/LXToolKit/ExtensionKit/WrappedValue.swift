//
//  WrappedValue.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation

// extension UIColor: NamespaceWrappable {}
// extension UIView: NamespaceWrappable {}
// extension NSObject: NamespaceWrappable {}

extension Array: SwiftyCompatible {}

extension String: SwiftyCompatible {}
extension StringTransform: SwiftyCompatible {}

extension Int: SwiftyCompatible {}
extension Int64: SwiftyCompatible {}

extension Unicode.Scalar: SwiftyCompatible {}
extension Date: SwiftyCompatible {}
extension CATransform3D: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}
// extension <#Type#>: SwiftyCompatible {}

// MARK: - 👀UIButton
@available(iOS 15.0, *)
extension UIButton.ConfigurationEnum: SwiftyCompatible {}
@available(iOS 15.0, *)
extension UIButton.Configuration.Size: SwiftyCompatible {}
@available(iOS 15.0, *)
extension UIButton.Configuration.CornerStyle: SwiftyCompatible {}
@available(iOS 15.0, *)
extension UIButton.Configuration.MacIdiomStyle: SwiftyCompatible {}
@available(iOS 15.0, *)
extension UIButton.Configuration.TitleAlignment: SwiftyCompatible {}

// MARK: - 👀UIListContentConfiguration
@available(iOS 14.0, *)
extension UIListContentConfiguration: SwiftyCompatible {}
