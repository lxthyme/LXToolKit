//
//  Service.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseApi {
    var path: String { get }
}

class RxProvider {
    static let shared = RxProvider()
    private init() {}
}
// MARK: - 👀
extension RxProvider: ReactiveCompatible { }

protocol RxRequestTarget {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
    var disposeBag: DisposeBag { get }
}

// MARK: - 👀
extension Reactive where Base: RxProvider {
    func req(isResource: Bool = false,
                 url: BaseApi,
                 params: [String: Any]?) ->Single<Any> {
        return self.req(isResource: isResource, url: url, params: params)
    }
}
