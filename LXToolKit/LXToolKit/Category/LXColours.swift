//
//  LXColours.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/22.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public extension UIColor {
    /// 提取给定颜色的 R, G, B, A值
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        return(red: red, green: green, blue: blue, alpha: alpha)
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
    class var random: UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    /// 返回随机色
//    public class var randomColor: UIColor {
//        return .random
//    }
}
public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {

        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }

    convenience init(hex: String, alpha: CGFloat = 1.0) {
//        var r: CGFloat = 0.0
//        var g: CGFloat = 0.0
//        var b: CGFloat = 0.0
//        var a: CGFloat = 1.0
//        var hex: String = hex
//
//        if hex.hasPrefix("#") {
//            let index = hex.index(hex.startIndex, offsetBy: 1)
//            hex = String(hex[index...])
//        }
//
//        let scanner = Scanner(string: hex)
//        var hexValue: CUnsignedLongLong = 0
//        if scanner.scanHexInt64(&hexValue) {
//            switch hex.count {
//            case 3:
//                r = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
//                g = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
//                b = CGFloat(hexValue & 0x00F)              / 15.0
//            case 4:
//                r = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
//                g = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
//                b = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
//                a = CGFloat(hexValue & 0x000F)             / 15.0
//            case 6:
//                r = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
//                g = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
//                b = CGFloat(hexValue & 0x0000FF)           / 255.0
//            case 8:
//                r = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
//                g = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
//                b = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
//                a = CGFloat(hexValue & 0x000000FF)         / 255.0
//            default:
//                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
//            }
//        } else {
//            print("Scan hex error")
//        }
//        self.init(red: r, green: g, blue: b, alpha: a)

//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
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
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    static func hex(_ hex: String, alpha: CGFloat = 1.0) ->UIColor {
        return UIColor(hex: hex, alpha: alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
