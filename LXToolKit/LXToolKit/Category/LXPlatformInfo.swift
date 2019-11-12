//
//  LXPlatformInfo.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/1.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public extension UIDevice {

    /// let modelName = UIDevice.currentDevice().ts_platform
    var xl_platform: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        //iPhone
        case "iPhone1,1": return "iPhone 1G"
        case "iPhone1,2": return "iPhone 3G"
        case "iPhone2,1": return "iPhone 3GS"
        case "iPhone3,1": return "iPhone 4 (GSM)"
        case "iPhone3,3": return "iPhone 4 (CDMA)"
        case "iPhone4,1": return "iPhone 4S"
        case "iPhone5,1": return "iPhone 5 (GSM)"
        case "iPhone5,2": return "iPhone 5 (CDMA)"
        case "iPhone5,3": return "iPhone 5c"
        case "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1": return "iPhone 5s"
        case "iPhone6,2": return "iPhone 5s"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1": return "iPhone 7"
        case "iPhone9,3": return "iPhone 7"
        case "iPhone9,2": return "iPhone 7 Plus"
        case "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1": return "iPhone 8"
        case "iPhone10,4": return "iPhone 8"
        case "iPhone10,2": return "iPhone 8 Plus"
        case "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3": return "iPhone X"
        case "iPhone10,6": return "iPhone X"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4": return "iPhone XS MAX"
        case "iPhone11,6": return "iPhone XS MAX"
        case "iPhone12,1": return "iPhone11"
        case "iPhone12,3": return "iPhone11 Pro"
        case "iPhone12,5": return "iPhone11 Pro Max"
        //iPod
        case "iPod1,1": return "iPod Touch 1G"
        case "iPod2,1": return "iPod Touch 2G"
        case "iPod3,1": return "iPod Touch 3G"
        case "iPod4,1": return "iPod Touch 4G"
        case "iPod5,1": return "iPod Touch 5G"
        case "iPod7,1": return "iPod Touch 6G"
        //iPad
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1": return "iPad 2 (WiFi)"
        case "iPad2,2": return "iPad 2 (GSM)"
        case "iPad2,3": return "iPad 2 (CDMA)"
        case "iPad2,4": return "iPad 2 (WiFi)"
        case "iPad2,5": return "iPad Mini (WiFi)"
        case "iPad2,6": return "iPad Mini (GSM)"
        case "iPad2,7": return "iPad Mini (CDMA)"
        case "iPad3,1": return "iPad 3 (WiFi)"
        case "iPad3,2": return "iPad 3 (CDMA)"
        case "iPad3,3": return "iPad 3 (GSM)"
        case "iPad3,4": return "iPad 4 (WiFi)"
        case "iPad3,5": return "iPad 4 (GSM)"
        case "iPad3,6": return "iPad 4 (CDMA)"
        case "iPad4,1": return "iPad Air (WiFi)"
        case "iPad4,2": return "iPad Air (GSM)"
        case "iPad4,3": return "iPad Air (CDMA)"
        case "iPad4,4": return "iPad Mini Retina (WiFi)"
        case "iPad4,5": return "iPad Mini Retina (Cellular)"
        case "iPad4,6": return "iPad mini Retina (China)"
        case "iPad4,7": return "iPad Mini 3 (WiFi)"
        case "iPad4,8": return "iPad Mini 3 (Cellular)"
        case "iPad4,9": return "iPad Mini 3 (Cellular)"
        case "iPad5,1": return "iPad Mini 4 (WiFi)"
        case "iPad5,2": return "iPad Mini 4 (Cellular)"
        case "iPad5,3": return "iPad Air 2 (WiFi)"
        case "iPad5,4": return "iPad Air 2 (Cellular)"
        case "iPad6,3": return "iPad Pro 9.7-inch (WiFi)"
        case "iPad6,4": return "iPad Pro 9.7-inch (Cellular)"
        case "iPad6,7": return "iPad Pro 12.9-inch (WiFi)"
        case "iPad6,8": return "iPad Pro 12.9-inch (Cellular)"
        case "iPad6,11": return "iPad (2017)"
        case "iPad6,12": return "iPad (2017)"
        case "iPad7,1": return "iPad Pro 2nd Gen (WiFi)"
        case "iPad7,2": return "iPad Pro 2nd Gen (WiFi+Cellular)"
        case "iPad7,3": return "iPad Pro 10.5-inch"
        case "iPad7,4": return "iPad Pro 10.5-inch"
        case "iPad7,5": return "iPad 6th Gen (WiFi)"
        case "iPad7,6": return "iPad 6th Gen (WiFi+Cellular)"
        case "iPad8,1": return "iPad Pro 3rd Gen (11 inch, WiFi)"
        case "iPad8,2": return "iPad Pro 3rd Gen (11 inch, 1TB, WiFi)"
        case "iPad8,3": return "iPad Pro 3rd Gen (11 inch, WiFi+Cellular)"
        case "iPad8,4": return "iPad Pro 3rd Gen (11 inch, 1TB, WiFi+Cellular)"
        case "iPad8,5": return "iPad Pro 3rd Gen (12.9 inch, WiFi)"
        case "iPad8,6": return "iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi)"
        case "iPad8,7": return "iPad Pro 3rd Gen (12.9 inch, WiFi+Cellular)"
        case "iPad8,8": return "iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi+Cellular)"
        //AppleTV
        case "AppleTV5,3": return "Apple TV"
        //Simulator
        case "i386", "x86_64": return "Simulator"
        default: return identifier
        }
    }
}
