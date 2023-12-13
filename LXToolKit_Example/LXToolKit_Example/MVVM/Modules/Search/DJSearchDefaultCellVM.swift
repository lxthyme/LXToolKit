//
//  DJSearchDefaultCellVM.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit

class DJSearchDefaultCellVM: LXBaseTableCellVM {
    // MARK: 🔗Vaiables
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let secondDetail = BehaviorRelay<String?>(value: nil)
    let attributedDetail = BehaviorRelay<NSAttributedString?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)
    let badge = BehaviorRelay<UIImage?>(value: nil)
    let badgeColor = BehaviorRelay<UIColor?>(value: nil)
    let hidesDisclosure = BehaviorRelay<Bool>(value: false)
    // MARK: 🛠Life Cycle
}

// MARK: 👀Public Actions
extension DJSearchDefaultCellVM {}

// MARK: 🔐Private Actions
private extension DJSearchDefaultCellVM {}
