//
//  LXMusicVM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

class LXMusicVM: NSObject {
    // MARK: 🔗Vaiables
    var dataList: Observable<[LXMusicModel?]> = {
        let data = [
            ["name": "无条件", "singer": "陈奕迅"],
            ["name": "你曾是少年", "singer": "S.H.E"],
            ["name": "从前的我", "singer": "陈洁仪"],
            ["name": "在木星", "singer": "朴树"]
        ]
        let list = [LXMusicModel].deserialize(from: data) ?? []
        return Observable.just(list)
    }()
    override init() {
        super.init()
    }
}

// MARK: 👀Public Actions
extension LXMusicVM {}

// MARK: 🔐Private Actions
private extension LXMusicVM {}
