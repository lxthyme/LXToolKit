//
//  LXBaseVM.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import LXToolKit

protocol LXViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class LXBaseVM: NSObject {
    deinit {
        dlog("\(type(of: self)): Deinited")
        LXPrint.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let provider: LXBaseAPI

    var page = 1

    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()

    let error = ErrorTracker()
    let serverError = PublishSubject<Error>()
    let parsedError = PublishSubject<ApiError>()
    // MARK: 🛠Life Cycle
    init(provider: LXBaseAPI) {
        self.provider = provider
        super.init()

        prepareUI()
    }
}

// MARK: 👀Public Actions
extension LXBaseVM {}

// MARK: 🔐Private Actions
private extension LXBaseVM {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVM {
    func prepareUI() {
        serverError.asObservable().map { (error) -> ApiError? in
            do {
                let errorResponse = error as? MoyaError
                if let body = try errorResponse?.response?.mapJSON() as? [String: Any],
                   let errorResponse = Mapper<ErrorResponse>().map(JSON: body) {
                    return ApiError.serverError(response: errorResponse)
                }
            } catch {
                print(error)
            }
            return nil
        }.filterNil().bind(to: parsedError).disposed(by: rx.disposeBag)

        parsedError.subscribe(onNext: { (error) in
            dlog("\(error)")
        }).disposed(by: rx.disposeBag)
    }
}
