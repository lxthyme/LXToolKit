//
//  DataModel.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//
import UIKit
import LXToolKit

public class DataModel: LXBaseObject {
    // MARK: 🔗Vaiables
    static var shared = DataModel()
    var countChangedBlock: ((_ count: Int) -> Void)?
    @objc var count = 0 {
        didSet {
            self.countChangedBlock?(count)
        }
    }
}

// MARK: 👀Public Actions
public extension DataModel {
    @discardableResult
    func increament() -> Int {
        self.count += 1
        return self.count
    }
    @discardableResult
    func decrement() -> Int {
        self.count -= 1
        return self.count
    }
}

// MARK: 🔐Private Actions
private extension DataModel {}
