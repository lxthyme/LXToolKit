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
open class LXBaseVM: LXBaseViewModel/**, LXViewModelType*/ {
    deinit {
        LogKit.traceLifeCycle(.vm, typeName: xl.typeNameString, type: .deinit)
        LogKit.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    
    // public let provider: DJAPI
    public var page = 1
    
    public let loading = ActivityIndicator()
    public let headerLoading = ActivityIndicator()
    public let footerLoading = ActivityIndicator()
    
    public let error = ErrorTracker()
    // public let serverError = PublishSubject<Error>()
    public let parsedError = PublishSubject<Error>()
    public override init() {
        // self.provider = provider
        super.init()
        
        basePrepareVM()
        basePrepareUI()
        baseMasonry()
    }
}

// MARK: 👀Public Actions
extension LXBaseVM {}

// MARK: 🔐Private Actions
private extension LXBaseVM {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVM {
    func basePrepareVM() {
        error.asObservable()
            .bind(to: parsedError)
            .disposed(by: rx.disposeBag)
        // serverError.asObserver()
        //     .bind(to: parsedError)
        //     .disposed(by: rx.disposeBag)
    }
    func basePrepareUI() {
        // self.view.backgroundColor = <#.white#>;
        // [<#table#>].forEach(self.<#view#>.addSubview)
        baseMasonry()
    }
    func baseMasonry() {}
}
