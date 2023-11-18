//
//  LXBaseViewModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit
import Foundation
import RxSwift
import Moya

open class LXBaseViewModel: NSObject {
    // let disposeBag = DisposeBag()
    public let provider = MoyaProvider<APIManager>(
//        endpointClosure: <#T##MoyaProvider<_>.EndpointClosure##MoyaProvider<_>.EndpointClosure##(_) -> Endpoint#>,
//        requestClosure: <#T##MoyaProvider<_>.RequestClosure##MoyaProvider<_>.RequestClosure##(Endpoint, @escaping MoyaProvider<_>.RequestResultClosure) -> Void#>,
//        stubClosure: <#T##MoyaProvider<_>.StubClosure##MoyaProvider<_>.StubClosure##(_) -> StubBehavior#>,
//        callbackQueue: <#T##DispatchQueue?#>,
//        session: <#T##Session#>,
//        plugins: <#T##[PluginType]#>,
//        trackInflights: <#T##Bool#>
    )
}
