//
//  LXBaseVM.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import UIKit

protocol LXViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

@objc(LXBaseSwiftVM)
open class LXBaseVM: NSObject {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let provider: DJAllAPI
    var page = 1

    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()

    let error = ErrorTracker()
    let serverError = PublishSubject<Error>()
    let parsedError = PublishSubject<ApiError>()
    deinit {
        print("-----> \(type(of: self)): Deinited")
#if DEBUG
// print("RxSwift resources count: \(RxSwift.Resources.total)")
#endif
    }
    public init(provider: DJAllAPI) {
        self.provider = provider
        super.init()

        serverError.asObserver()
            .map { error -> ApiError? in
                do {
                    let errorResponse = error as? MoyaError
                    if let body = try errorResponse?.response?.mapJSON() as? [String: Any],
                       let model = ErrorResponse.deserialize(from: body) {
                        return ApiError.serverError(response: model)
                    }
                } catch {
                    print("error: \(error)")
                }
                return nil
            }
            .filterNil()
            .bind(to: parsedError)
            .disposed(by: rx.disposeBag)

        parsedError
            .subscribe { error in
                print("error: \(error)")
            }
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension LXBaseVM {}

// MARK: 🔐Private Actions
private extension LXBaseVM {}
