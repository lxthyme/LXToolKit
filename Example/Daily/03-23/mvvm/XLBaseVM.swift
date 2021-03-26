//
//  LXBaseVM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

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
    let provider: XLAPI

    var page = 1

    let loading = RxActivityIndicator()
    let headerLoading = RxActivityIndicator()
    let footerLoading = RxActivityIndicator()

    let error = ErrorTracker()
    let serverError = PublishSubject<Error>()
    let parsedError = PublishSubject<ApiError>()

    init(provider: XLAPI) {
        self.provider = provider
        super.init()

        serverError
            .asObserver()
            .map { error -> ApiError? in
                do {
                    let errorResponse = error as? MoyaError
                    if let body = try errorResponse?.response?.mapJSON() as? [String: Any],
                       let errorResponse = Mapper<ErrorResponse>().map(JSON: body) {
                        return ApiError.serverError(response: errorResponse)
                    }
                } catch {
                    Logger.error("🛠serverError: \(error)")
                }
                return nil
            }
            .filterNil()
            .bind(to: parsedError)
            .disposed(by: rx.disposeBag)

        parsedError
            .subscribe(onNext: { error in
                Logger.error("🛠1. onNext - parsedError: \(error)")
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension XLBaseVM {}

// MARK: 🔐Private Actions
private extension XLBaseVM {}
