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
    // var countChangedBlock: (count: Int) -> Void
    @objc var count = 0
}

// MARK: 👀Public Actions
public extension DataModel {
    func increament() {
        self.count += 1
    }
    func decrement() {
        self.count -= 1
    }
}

// MARK: 🔐Private Actions
private extension DataModel {}
