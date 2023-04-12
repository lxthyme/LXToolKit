//
//  LibsManager.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import FLEX

class LibsManager: NSObject {
    // MARK: 🔗Vaiables
    static let shared = LibsManager()
    let bannersEnabled = BehaviorRelay(value: UserDefaults.standard.bool(forKey: AppConfig.UserDefaultsKeys.bannersEnabled))
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    private override init() {
        super.init()

        if UserDefaults.standard.object(forKey: AppConfig.UserDefaultsKeys.bannersEnabled) == nil {
            bannersEnabled.accept(true)
        }

        bannersEnabled
            .skip(1)
            .subscribe { enabled in
                UserDefaults.standard.set(enabled, forKey: AppConfig.UserDefaultsKeys.bannersEnabled)
            }
            .disposed(by: rx.disposeBag)
    }

}

// MARK: 👀Public Actions
extension LibsManager {
    func setupLibs() {
        let libsManager = LibsManager.shared
        // libsManager.showFlex()
    }
    func showFlex() {
        #if DEBUG
        FLEXManager.shared.showExplorer()
        #endif
    }
}

// MARK: 🔐Private Actions
private extension LibsManager {}
