//
//  Macro.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

public enum LXMacro {}

// MARK: - 👀Screen
extension LXMacro {
    private static let screen = UIApplication.XL.keyWindow?.screen ?? UIScreen.main
    public enum Screen {
        public static let width = LXMacro.screen.bounds.width
        public static let height = LXMacro.screen.bounds.height
    }
}

// MARK: - 👀Path
extension LXMacro {
    public struct Path {
        public static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        public static let Tmp = NSTemporaryDirectory()

        public static let assetDir: URL = {
            let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
        }()
    }
}

// MARK: - 👀BuildConfiguration
extension LXMacro {
    public enum BuildConfiguration {
        public enum Error: Swift.Error {
            case missingKey, invalidValue(value: Any)
        }
        static func value<T>(for key: String) throws -> T {
            guard let obj = Bundle.main.object(forInfoDictionaryKey: key) else {
                throw Error.missingKey
            }

            switch obj {
            case let value as T:
                return value
            // case let value as String:
            //     guard let value = T(value) else { fallthrough }
            //     return value
                // return T(value)
            default: throw Error.invalidValue(value: obj)
            }
        }
        public static subscript<T>(key: String) -> T where T: AnyObject {
            get throws {
                return try BuildConfiguration.value(for: key)
            }
        }
    }
}

// MARK: - 👀InfoPlistKey
extension LXMacro {
    public enum InfoPlistKey {
        case CFBundleDisplayName
        case CFBundleShortVersionString
        case CFBundleName
        case CFBundleIdentifier
        case CFBundleVersion
        case MARKETING_VERSION
        case PRODUCT_BUNDLE_IDENTIFIER
        case PRODUCT_NAME
        case CURRENT_PROJECT_VERSION
        case NSUserActivityTypes
        case custom(key: String)

        var key: String {
            switch self {
            case .CFBundleDisplayName: return "CFBundleDisplayName"
            case .CFBundleShortVersionString: return "CFBundleShortVersionString"
            case .CFBundleName: return "CFBundleName"
            case .CFBundleIdentifier: return "CFBundleIdentifier"
            case .CFBundleVersion: return "CFBundleVersion"
            case .MARKETING_VERSION: return "MARKETING_VERSION"
            case .PRODUCT_BUNDLE_IDENTIFIER: return "PRODUCT_BUNDLE_IDENTIFIER"
            case .PRODUCT_NAME: return "PRODUCT_NAME"
            case .CURRENT_PROJECT_VERSION: return "CURRENT_PROJECT_VERSION"
            case .NSUserActivityTypes: return "NSUserActivityTypes"
            case .custom(let key): return key
            }
        }
        public static subscript<T>(key: InfoPlistKey) -> T {
            get throws {
                return try BuildConfiguration.value(for: key.key)
            }
        }
    }
}

// MARK: - 👀PrivacyKey
extension LXMacro {
    /**
     <key>NSBluetoothAlwaysUsageDescription</key>
     <string>APP需要您的同意才能使用蓝牙，以便您及时获取附近商场的活动和优惠信息</string>
     <key>NSBluetoothPeripheralUsageDescription</key>
     <string>APP需要您的同意才能使用蓝牙，以便您及时获取附近商场的活动和优惠信息</string>
     <key>NSCalendarsUsageDescription</key>
     <string>APP需要使用您的日历为您提供定时提醒服务</string>
     <key>NSCameraUsageDescription</key>
     <string>&quot;APP&quot;想访问您的相机，为了帮您扫描二维码或商品和互动等功能</string>
     <key>NSContactsUsageDescription</key>
     <string>APP需要访问您的通讯录，以便您在购物时正常查阅、取用您的联系人信息</string>
     <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
     <string>APP需要获取您的位置信息，以便您及时获取附近商场的活动和优惠信息</string>
     <key>NSLocationAlwaysUsageDescription</key>
     <string>APP需要获取您的位置信息，以便您及时获取附近商场的活动和优惠信息</string>
     <key>NSLocationTemporaryUsageDescriptionDictionary</key>
     <dict>
     <key>purposeKey4changeInfo</key>
     <string>用于向您推荐附近的商品、店铺及优惠资讯</string>
     </dict>
     <key>NSLocationWhenInUseUsageDescription</key>
     <string>APP需要获取您的位置信息，以便您及时获取附近商场的活动和优惠信息</string>
     <key>NSMicrophoneUsageDescription</key>
     <string>APP需要您的同意才能使用麦克风，以便您正常使用语音搜索功能</string>
     <key>NSPhotoLibraryAddUsageDescription</key>
     <string>APP需要访问您的相册，以便您正常使用扫一扫、评论晒照等服务</string>
     <key>NSPhotoLibraryUsageDescription</key>
     <string>APP需要访问您的相册，以便您正常使用扫一扫、评论晒照、保存发票等服务</string>
     <key>NSRemindersUsageDescription</key>
     <string>APP需要使用您的日历为您提供定时提醒服务</string>
     <key>UIAppFonts</key>
     */
    public enum PrivacyKey: String {
        case NSBluetoothAlwaysUsageDescription
        case NSBluetoothPeripheralUsageDescription
        case NSCalendarsUsageDescription
        case NSCameraUsageDescription
        case NSContactsUsageDescription
        case NSLocationAlwaysAndWhenInUseUsageDescription
        case NSLocationAlwaysUsageDescription
        case NSLocationTemporaryUsageDescriptionDictionary
        case NSLocationWhenInUseUsageDescription
        case NSMicrophoneUsageDescription
        case NSPhotoLibraryAddUsageDescription
        case NSPhotoLibraryUsageDescription
        case NSRemindersUsageDescription
        case UIAppFonts

        public static subscript<T>(key: PrivacyKey) -> T where T: LosslessStringConvertible {
            get throws {
                return try BuildConfiguration.value(for: key.rawValue)
            }
        }
    }
}
