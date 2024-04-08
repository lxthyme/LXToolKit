//
//  DataModel.swift
//  LXTest
//
//  Created by lxthyme on 2023/12/26.
//
import UIKit
import LXToolKit
import RxRelay

public class DataModel: LXBaseObject {
    // MARK: 🔗Vaiables
    static var shared = DataModel()
    let count = BehaviorRelay(value: 0)
}

// MARK: 👀Public Actions
public extension DataModel {
    func increament() {
        self.count.accept(self.count.value + 1)
    }
    func decrement() {
        self.count.accept(self.count.value - 1)
    }
}

// MARK: 🔐Private Actions
private extension DataModel {}
