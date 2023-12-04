//
//  LXFileManager.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/17.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import UIKit
//import Result

public class LXFileManager: NSObject {
    public static let instance = LXFileManager()
    public static let fm: FileManager = {
        return FileManager.default
    }()
    private override init() { }
}

// MARK: Public Actions
public extension LXFileManager {}

// MARK: Private Actions
private extension LXFileManager {}

public extension LXFileManager {
    static let libraryDirectory: String = {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
    }()
    static let documentDirectory: String = {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }()
    static let cachesDirectory: String = {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }()
    static let preferencePanesDirectory: String = {
        return NSSearchPathForDirectoriesInDomains(.preferencePanesDirectory, .userDomainMask, true).first!
    }()
    static func directory(_ type: FileManager.SearchPathDirectory) -> String {
        return NSSearchPathForDirectoriesInDomains(type, .userDomainMask, true).first!
    }
//    func run(after: TimeInterval, done: @escaping (Result<Timer, NoError>) -> Void ) {
//    }
    static func removeItem(atPath path: String, completion: ((Result<Bool, LXError>) -> Void)?) {
        do {
            try fm.removeItem(atPath: path)
            completion?(.success(true))
        } catch {
            logger.error("Error: \(error)")
            completion?(.failure(error as! LXError))
        }
    }
}
