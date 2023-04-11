//
//  LXBaseVM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

protocol XLViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class XLBaseVM: NSObject {
    deinit {
        Logger.debug("🛠deinit: \(type(of: self))")
        Logger.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let loading = RxActivityIndicator()
    let headerLoading = RxActivityIndicator()
    let footerLoading = RxActivityIndicator()
    var page = 1
    let emptyDataSet = BehaviorRelay<XLEmptyDataSet?>(value: nil)

    let provider: XLAPI
    let error = ErrorTracker()

    init(provider: XLAPI) {
        self.provider = provider
        super.init()

        
    }
}

// MARK: 👀Public Actions
extension Observable {
    func deal(_ element: Element, _ errorTracker: ErrorTracker)
        -> Observable<Element> {
        return catchError({ error -> Observable<Element> in
            Logger.error("deal: \(error)")
            return Observable.just(element)
        })
            .trackError(errorTracker)
    }
}

// MARK: 🔐Private Actions
private extension XLBaseVM {}
