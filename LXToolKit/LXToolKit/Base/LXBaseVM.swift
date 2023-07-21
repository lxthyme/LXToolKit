//
//  LXBaseVM.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import Moya

public protocol LXViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

@objc(LXBaseKitVM)
open class LXBaseVM: NSObject/**, LXViewModelType*/ {
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
        LXPrint.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    
    public let provider: DJAPI
    public var page = 1
    
    public let loading = ActivityIndicator()
    public let headerLoading = ActivityIndicator()
    public let footerLoading = ActivityIndicator()
    
    public let error = ErrorTracker()
    public let serverError = PublishSubject<Error>()
    public let parsedError = PublishSubject<ApiError>()
    public init(provider: DJAPI) {
        self.provider = provider
        super.init()
        
        prepareVM()
    }
}

// MARK: 👀Public Actions
extension LXBaseVM {}

// MARK: 🔐Private Actions
private extension LXBaseVM {}

// MARK: - 🍺UI Prepare & Masonry
extension LXBaseVM {
    func prepareVM() {
        serverError.asObserver()
            .map { error -> ApiError? in
                do {
                    let errorResponse = error as? MoyaError
                    // if let body = try errorResponse?.response?.mapJSON() as? [String: Any],
                    //    let model = ErrorResponse.deserialize(from: body) {
                    //     return ApiError.serverError(response: model)
                    // }
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
    func prepareUI() {
        // self.view.backgroundColor = <#.white#>;
        // [<#table#>].forEach(self.<#view#>.addSubview)
        masonry()
    }
    func masonry() {}
}
