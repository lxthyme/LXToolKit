//
//  DJLanguagesVM.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit

class DJLanguagesVM: LXBaseVM {
    // MARK: 🔗Vaiables
    let currentLanguage: BehaviorRelay<LanguageModel?>
    let languages: BehaviorRelay<[LanguageModel]>
    // MARK: 🛠Life Cycle
    init(currentLanguage: LanguageModel?, languages: [LanguageModel]) {
        self.currentLanguage = BehaviorRelay(value: currentLanguage)
        self.languages = BehaviorRelay(value: languages)
        super.init()
    }
}

// MARK: 👀Public Actions
extension DJLanguagesVM {}

// MARK: 🔐Private Actions
private extension DJLanguagesVM {}
