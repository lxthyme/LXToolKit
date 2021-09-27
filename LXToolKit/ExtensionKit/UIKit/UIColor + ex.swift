//
//  LXColours.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/22.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

// MARK: - 👀XL
//public extension UIColor {
//    static var xl: Swifty<UIColor>.Type {
//        return UIColor.xl
//    }
//}

// MARK: - 👀lx
//public extension TypeWrapperProtocol where BaseType == UIColor {
public extension Swifty where Base: UIColor {
    /// 提取给定颜色的 R, G, B, A值
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        guard base.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        return (red: red, green: green, blue: blue, alpha: alpha)
    }
    /// 给出适宜的颜色值域
    /// 0 ~ 1: 不转换格式
    /// 1 ~ 255: x / 255.0
    private static func flex(_ f: CGFloat) -> CGFloat {
        guard f > 1.0 else {
            return max(f, 0.0)
        }
        let r = min(f, 255.0) / 255.0
        return r
    }
    /// 根据指定rgba, 生成相应颜色
    /// 0 ~ 1: 不转换格式
    /// 1 ~ 255: x / 255.0
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: flex(red),
                       green: flex(green),
                       blue: flex(blue),
                       alpha: max(alpha, 1.0))
    }
    /// 生成随机的颜色
    static var random: UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
//public extension TypeWrapperProtocol where BaseType == UIColor {
public extension Swifty where Base: UIColor {
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")

        return Base(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)

    }
    static func hex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hex.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

//        self.init(r:red, g:green, b:blue, alpha:alpha)
        return Base(red: red, green: green, blue: blue, alpha: alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        base.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
