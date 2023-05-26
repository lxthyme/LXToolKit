//
//  DJLanguagesVM.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit
import LXToolKit

class DJLanguagesVM: LXBaseVM {
    // MARK: 🔗Vaiables
    let currentLanguage: BehaviorRelay<LanguageModel?>
    let languages: BehaviorRelay<[LanguageModel]>
    // MARK: 🛠Life Cycle
    init(currentLanguage: LanguageModel?, languages: [LanguageModel], provider: DJAllAPI) {
        self.currentLanguage = BehaviorRelay(value: currentLanguage)
        self.languages = BehaviorRelay(value: languages)
        super.init(provider: provider)
    }
}

// MARK: 👀Public Actions
extension DJLanguagesVM {}

// MARK: 🔐Private Actions
private extension DJLanguagesVM {}
