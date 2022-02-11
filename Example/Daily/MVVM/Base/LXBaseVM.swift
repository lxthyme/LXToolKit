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
        logDebug("\(type(of: self)): Deinited")
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
            logError("\(error)")
        }).disposed(by: rx.disposeBag)

//         error
//             .asDriver()
//             .drive(onNext: {[weak self] error in
//                 guard let `self` = self else { return }
//                 Logger.error("🛠1. onNext: \(error)")
//                 var emptySet = XLEmptyDataSet(title: "", description: "", img: nil, imgTintColor: BehaviorRelay<UIColor?>(value: .red))
//                 if let apiError = error as? ApiError {
//                     emptySet.identifier = apiError.identifier
//                     switch apiError {
//                     case .offline:
//                         emptySet.title = "没有网络!"
//                         emptySet.description = "「1」检测到设备没有联网, 请确认后重试~"
//                     case .serverError(let response, let error):
//                         emptySet.title = "服务器错误!"
//                         emptySet.description = """
// 「2」服务器错误, 请稍后重试~
//     -->response: \(response.debugDescription)
//     -->error: \(error.debugDescription)
// """
//                     case .serializeError(let response, let error):
//                         emptySet.title = "序列化错误!"
//                         emptySet.description = """
// 「3」序列化错误, 请稍后重试~
//     -->response: \(response.debugDescription)
//     -->error: \(error.debugDescription)
// """
//                     case .nocontent:
//                         emptySet.title  = "没有内容!"
//                         emptySet.description = "「4」暂时没有更多内容, 请稍后重试~"
//                     case .invalidStatusCode(let statusCode, let tips):
//                         emptySet.title = "code 错误[\(statusCode ?? 999)"
//                         emptySet.description = "「5」code 错误~ -> \(tips ?? "--")"
//                     }
//                 } else if let moyaError = error as? MoyaError {
//                     emptySet.identifier = "\(moyaError.errorCode)"
//                     emptySet.title = "\(moyaError.failureReason ?? "")"
//                     emptySet.description = "「moya」\(moyaError.errorDescription ?? "")"
//                 } else {
//                     let error = error as NSError
//                     emptySet.identifier = "\(error.code)"
//                     emptySet.title = "「else」\(error.domain)"
//                     emptySet.description = error.localizedDescription
//                 }
//                 self.emptyDataSet.accept(emptySet)
//             })
//             .disposed(by: rx.disposeBag)
    }
}
