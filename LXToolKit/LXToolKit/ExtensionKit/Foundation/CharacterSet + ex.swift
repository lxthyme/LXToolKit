//
//  CharacterSet + ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2024/3/6.
//

import Foundation

// MARK: - 👀
extension CharacterSet {
    public enum Ex: CaseIterable {
        case controlCharacters
        case whitespaces
        case whitespacesAndNewlines
        case decimalDigits
        case letters
        case lowercaseLetters
        case uppercaseLetters
        case nonBaseCharacters
        case alphanumerics
        case decomposables
        case illegalCharacters
        case punctuationCharacters
        case capitalizedLetters
        case symbols
        case newlines
        case urlUserAllowed
        case urlPasswordAllowed
        case urlHostAllowed
        case urlPathAllowed
        case urlQueryAllowed
        case urlFragmentAllowed

        public var title: String {
            switch self {
            case .controlCharacters: return ".controlCharacters"
            case .whitespaces: return ".whitespaces"
            case .whitespacesAndNewlines: return ".whitespacesAndNewlines"
            case .decimalDigits: return ".decimalDigits"
            case .letters: return ".letters"
            case .lowercaseLetters: return ".lowercaseLetters"
            case .uppercaseLetters: return ".uppercaseLetters"
            case .nonBaseCharacters: return ".nonBaseCharacters"
            case .alphanumerics: return ".alphanumerics"
            case .decomposables: return ".decomposables"
            case .illegalCharacters: return ".illegalCharacters"
            case .punctuationCharacters: return ".punctuationCharacters"
            case .capitalizedLetters: return ".capitalizedLetters"
            case .symbols: return ".symbols"
            case .newlines: return ".newlines"
            case .urlUserAllowed: return ".urlUserAllowed"
            case .urlPasswordAllowed: return ".urlPasswordAllowed"
            case .urlHostAllowed: return ".urlHostAllowed"
            case .urlPathAllowed: return ".urlPathAllowed"
            case .urlQueryAllowed: return ".urlQueryAllowed"
            case .urlFragmentAllowed: return " .urlFragmentAllowed"
            }
        }
        public var characterSet: CharacterSet {
            switch self {
            case .controlCharacters: return .controlCharacters
            case .whitespaces: return .whitespaces
            case .whitespacesAndNewlines: return .whitespacesAndNewlines
            case .decimalDigits: return .decimalDigits
            case .letters: return .letters
            case .lowercaseLetters: return .lowercaseLetters
            case .uppercaseLetters: return .uppercaseLetters
            case .nonBaseCharacters: return .nonBaseCharacters
            case .alphanumerics: return .alphanumerics
            case .decomposables: return .decomposables
            case .illegalCharacters: return .illegalCharacters
            case .punctuationCharacters: return .punctuationCharacters
            case .capitalizedLetters: return .capitalizedLetters
            case .symbols: return .symbols
            case .newlines: return .newlines
            case .urlUserAllowed: return .urlUserAllowed
            case .urlPasswordAllowed: return .urlPasswordAllowed
            case .urlHostAllowed: return .urlHostAllowed
            case .urlPathAllowed: return .urlPathAllowed
            case .urlQueryAllowed: return .urlQueryAllowed
            case .urlFragmentAllowed: return  .urlFragmentAllowed
            }
        }
    }
}

// MARK: - 👀
extension CharacterSet.Ex: CustomStringConvertible {
    public var description: String {
        return characterSet.allCharacters().description
    }
}

// MARK: - 👀
extension CharacterSet {
    public func allCharacters() -> [Character] {
        var result: [Character] = []
        for tmp in [0...16] {
            let plane = tmp.lowerBound
            if !self.hasMember(inPlane: UInt8(plane)) {
                continue
            }
            for unicode in UInt32(plane) << 16 ..< UInt32(plane + 1) << 16 {
                if let uniChar = UnicodeScalar(unicode),
                   self.contains(uniChar) {
                    result.append(Character(uniChar))
                }
            }
        }
        return result
    }
}
