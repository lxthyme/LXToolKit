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

        error
            .asDriver()
            .drive(onNext: {[weak self] error in
                guard let `self` = self else { return }
                Logger.error("🛠1. onNext: \(error)")
                var emptySet = XLEmptyDataSet(title: "", description: "", img: nil, imgTintColor: BehaviorRelay<UIColor?>(value: .red))
                if let apiError = error as? ApiError {
                    emptySet.identifier = apiError.identifier
                    switch apiError {
                    case .offline:
                        emptySet.title = "没有网络!"
                        emptySet.description = "「1」检测到设备没有联网, 请确认后重试~"
                    case .serverError(let response):
                        emptySet.title = "服务器错误!"
                        emptySet.description = "「2」服务器错误, 请稍后重试~ -->\(response.debugDescription)"
                    case .serializeError(let response):
                        emptySet.title = "序列化错误!"
                        emptySet.description = "「3」序列化错误, 请稍后重试~ -->\(response.debugDescription)"
                    case .nocontent(let response):
                        emptySet.title  = "没有内容!"
                        emptySet.description = "「4」暂时没有更多内容, 请稍后重试~ -->\(response.debugDescription)"
                    case .invalidStatusCode(let statusCode, let msg, let tips):
                        emptySet.title = "code 错误[\(statusCode)"
                        emptySet.description = "「5」code 错误~ \(msg) <-> \(tips)"
                    }
                } else if let moyaError = error as? MoyaError {
                    emptySet.identifier = "\(moyaError.errorCode)"
                    emptySet.title = "\(moyaError.failureReason ?? "")"
                    emptySet.description = "「moya」\(moyaError.errorDescription ?? "")"
                } else {
                    let error = error as NSError
                    emptySet.identifier = "\(error.code)"
                    emptySet.title = "「else」\(error.domain)"
                    emptySet.description = error.localizedDescription
                }
                self.emptyDataSet.accept(emptySet)
            })
            .disposed(by: rx.disposeBag)
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
