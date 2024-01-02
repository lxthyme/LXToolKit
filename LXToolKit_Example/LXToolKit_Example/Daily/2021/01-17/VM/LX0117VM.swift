//
//  LX0117VM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

struct  WOLGrowthHistoryApiService {
    /// 当前请求页码
    var currentPage = 1
    /// 请求Action
    lazy var historyListRequest = Action<WOLGrowthHistoryApiServiceDicModel, LX0117Model>.init { (model) -> Observable<LX0117Model> in
        LXNetworking<SongService>
            .defaultNetworking()
            .request(.growthRecord(page: 1, lastYearMonth: "01", last_id: "123"))
            .mapHandyJSON(LX0117Model.self)
    }
}

struct WOLGrowthHistoryApiServiceDicModel {
    var page: Int = 0
    var lastYearMonth: String = ""
    var last_id: String = ""
}

enum WOLRequestType {
    /// 下拉刷新
    case down
    /// 上拉刷新
    case up
}

class LX0117VM {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var input       = Input()
    var output      = Output()
    var apiService  = WOLGrowthHistoryApiService()
    var currenRequestType = WOLRequestType.down
}

// MARK: - 👀
extension LX0117VM {
    struct Input {
        /// 下拉刷新事件
        lazy var headerRefresh = PublishSubject<Void>()
        /// 上拉刷新事件
        lazy var footerRefresh = PublishSubject<WOLGrowthHistoryApiServiceDicModel>()
        /// 重新刷新
        lazy var retryObservable = PublishSubject<Void>()

    }
    struct Output {
        /// 请求数据
        lazy var requestData = PublishSubject<(LX0117Model, WOLRequestType)>()
        /// 请求异常处理
        lazy var requestError = PublishSubject<ActionError>()
        /// 上拉刷新状态输出
        lazy var footerState = PublishSubject<Int>()
    }
}

// MARK: 👀Public Actions
extension LX0117VM {}

// MARK: 🔐Private Actions
private extension LX0117VM {}
