//
//  LXNavigationController.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Hero
import RswiftResources
import RxTheme

open class LXNavigationController: UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        basePrepareUI()
    }

}

// MARK: 🌎LoadData
extension LXNavigationController {}

// MARK: 👀Public Actions
extension LXNavigationController {}

// MARK: 🔐Private Actions
private extension LXNavigationController {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXNavigationController {
    func basePrepareUI() {
        // Enable default iOS back swipe gesture
        interactivePopGestureRecognizer?.delegate = nil

        if #available(iOS 13.0, *) {
            hero.isEnabled = false
        } else {
            hero.isEnabled = true
        }
        hero.modalAnimationType = .autoReverse(presenting: .fade)
        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))

        // navigationBar.isTranslucent = false
        // navigationBar.backIndicatorImage = R.image.icon_navigation_back()
        // navigationBar.backIndicatorTransitionMaskImage = R.image.icon_navigation_back()

        // navigationBar.theme.tintColor = themeService.attribute { $0.secondary }
        // navigationBar.theme.barTintColor = themeService.attribute { $0.primaryDark }
        // navigationBar.theme.titleTextAttributes = themeService.attribute { [NSAttributedString.Key.foregroundColor: $0.text] }
    }
}
