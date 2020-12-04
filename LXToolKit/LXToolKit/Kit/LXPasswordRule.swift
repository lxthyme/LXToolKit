//
//  PasswordRule.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/11/7.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public enum PasswordRule {
    public enum CharacterClass {
        case upper, lower, digits, special, asciiPrintable, unicode
        case custom(Set<Character>)
    }

    case required(CharacterClass)
    case allowed(CharacterClass)
    case maxConsecutive(UInt)
    case minLength(UInt)
    case maxLength(UInt)
}

extension PasswordRule: CustomStringConvertible {
    public var description: String {
        switch self {
        case .required(let characterClass):
            return "required: \(characterClass)"
        case .allowed(let characterClass):
            return "allowed: \(characterClass)"
        case .maxConsecutive(let length):
            return "max-consecutive: \(length)"
        case .minLength(let length):
            return "minlength: \(length)"
        case .maxLength(let length):
            return "maxlength: \(length)"
        }
    }
}

extension PasswordRule.CharacterClass: CustomStringConvertible {
    public var description: String {
        switch self {
        case .upper: return "upper"
        case .lower: return "lower"
        case .digits: return "digits"
        case .special: return "special"
        case .asciiPrintable: return "ascii-printable"
        case .unicode: return "unicode"
        case .custom(let characters):
            return "[" + String(characters) + "]"
        }
    }
}

@available(iOS 12.0, *)
public extension UITextInputPasswordRules {
    convenience init(rules: [PasswordRule]) {
        let descriptor = rules.map { $0.description }
            .joined(separator: "; ")

        self.init(descriptor: descriptor)
    }
}
