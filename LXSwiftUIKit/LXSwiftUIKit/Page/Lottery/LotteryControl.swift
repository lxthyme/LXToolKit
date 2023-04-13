//
//  LotteryControl.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2022/9/7.
//
import UIKit

class LotteryControl: ObservableObject {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    @Published var rotation = 0.0
    let index = 8
    var angle: Double { 360 / Double(index) }
    init() {
        print("init runed:\(angle)")
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.rotation += 30
        }
    }
}

// MARK: 👀Public Actions
extension LotteryControl {}

// MARK: 🔐Private Actions
private extension LotteryControl {}
