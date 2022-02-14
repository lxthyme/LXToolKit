//
//  LXNavigationController.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Hero
import Rswift
import RxTheme

open class LXNavigationController: UINavigationController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return globalStatusBarStyle.value
    }
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
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
    func prepareUI() {
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
        navigationBar.backIndicatorImage = R.image.icon_navigation_back()
        navigationBar.backIndicatorTransitionMaskImage = R.image.icon_navigation_back()

        navigationBar.theme.tintColor = themeService.attribute { $0.secondary }
        // navigationBar.theme.barTintColor = themeService.attribute { $0.primaryDark }
        navigationBar.theme.titleTextAttributes = themeService.attribute { [NSAttributedString.Key.foregroundColor: $0.text] }
    }
}
