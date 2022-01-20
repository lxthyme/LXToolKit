//
//  LXBaseNavController.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXBaseNavController: UINavigationController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        interactivePopGestureRecognizer?.delegate = nil

        if #available(iOS 13.0, *) {
            hero.isEnabled = false
        } else {
            hero.isEnabled = true
        }
        hero.modalAnimationType = .autoReverse(presenting: .fade)
        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))

        navigationBar.isTranslucent = false
        navigationBar.backIndicatorImage = R.image.icon_navigation_back()
        navigationBar.backIndicatorTransitionMaskImage = R.image.icon_navigation_back()
    }

}

// MARK: 🌎LoadData
extension LXBaseNavController {}

// MARK: 👀Public Actions
extension LXBaseNavController {}

// MARK: 🔐Private Actions
private extension LXBaseNavController {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseNavController {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
