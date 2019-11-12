//
//  LXRegexKit.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/1.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

public class LXRegexKit: NSObject { }

public extension LXRegexKit {
    enum Validator: String {
        /// 纯数字
        case number = "[0-9]*"
        /// 手机号码
        case tel = "0?(13|14|15|16|17|18|19)[0-9]{9}$"
        /// 大陆身份证号码
        case idCard = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[X|x])"
        /// 香港身份证号码
        case hkIdCard = "^[A-Z]{1,2}[0-9]{6}\\(?[0-9A]\\)?$"
        /// 护照
        case passport = "^1[45][0-9]{7}|([P|p|S|s]\\d{7})|([S|s|G|g]\\d{8})|([Gg|Tt|Ss|Ll|Qq|Dd|Aa|Ff]\\d{8})|([H|h|M|m]\\d{8，10})$"
        /// 密码（格式包含大写、小写、数字）
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[a-zA-Z0-9]{6,20}"
    }
}

public extension LXRegexKit {
    static func evaluate(_ string: String, regex: String) ->Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: string)
    }

    static func iss(_ string: String, _ regex: LXRegexKit.Validator) ->Bool {
        guard !string.isEmpty, !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }

        return evaluate(string, regex: regex.rawValue)
    }
}

public extension LXRegexKit {
    /// 验证是否是纯数字
    static func isAllNumber(string: String, regex: LXRegexKit.Validator = .number) ->Bool {
        return iss(string, regex)
    }
    /// 验证手机号码
    static func isTel(string: String, regex: LXRegexKit.Validator = .tel) ->Bool {
        return iss(string, regex)
    }
    /// 验证身份证号码
    static func isIdCard(string: String, regex: LXRegexKit.Validator = .idCard) ->Bool {
        return iss(string, regex)
    }
    /// 验证香港身份证号码
    static func isHKIdCard(string: String, regex: LXRegexKit.Validator = .hkIdCard) ->Bool {
        return iss(string, regex)
    }
    /// 验证是否护照
    static func isPassport(string: String, regex: LXRegexKit.Validator = .passport) ->Bool {
        return iss(string, regex)
    }
    /// 验证密码格式（包含大写、小写、数字）
    static func validatePassword(string: String, regex: LXRegexKit.Validator = .password) ->Bool {
        return iss(string, regex)
    }
}
