//
//  LXSongVM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import Action
import RxCocoa
import LXToolKit

struct SongRecordListService {
//    lazy var getRecordList = Action<Int, LXBaseListModel<LXSongRecordItemModel>> { body -> Observable<LXBaseListModel<LXSongRecordItemModel>> in
////        return RxProvider.shared.rx
////            .req(isResource: true,
////                 url: ApiService.recordList,
////                 params: [
////                    "sort":["edit_time":"desc"].description,
////                    "page":body,
////                    "per-page":18
////                 ])
////            .asObservable()
////            .mapModel(LXSongModel.self)
//        return apiProvider
//            .req(target: SongService.recordList(sort: ["edit_time": "desc"].description, page: body, pageSize: 18))
//            .mapBaseModelArray(LXSongRecordItemModel.self)
//    }
}

class LXSongVM: NSObject {
    // MARK: 📌UI
    struct Input {
        lazy var headerRefresh = PublishSubject<Void>()
        lazy var footerRefresh = PublishSubject<Void>()
        lazy var retry = PublishSubject<Void>()
    }
    struct Output {
        let dataSource = BehaviorSubject<[LXSongCellVM]>(value: [])
        lazy var emptyData = BehaviorSubject<LXEmptyType>(value: .success)
        lazy var footerState = PublishSubject<(current: Int, pageSize: Int)>()
    }
    // MARK: 🔗Vaiables
    var input = Input()
    var output = Output()
    private var service: SongRecordListService
    init(pageStatus: SongSegmentStatus, apiService: SongRecordListService, disposeBag: DisposeBag) {
        service = apiService

        let page = BehaviorSubject(value: 1)
        /// 请求数据 + 翻页 + 数组自增
//        let d = service.getRecordList.elements
//            .observeOn(MainScheduler.instance)
//            .hideLoading()
//            .map { item -> [LXSongCellVM] in
//                return item.list?.compactMap { LXSongCellVM($0, pageStatus: pageStatus) } ?? []
//            }
//            .do(onNext: { (_) in
//                page.onNext(try page.value() + 1)
//                dlog("PAGE: \(try page.value())")
//            })
//            .scan([], accumulator: {
//                return (try page.value() == 1) ? $1 : $0 + $1
//            })
//            .bind(to: output.dataSource)
//            .disposed(by: disposeBag)

        /// 返回底部刷新状态
//        service.getRecordList.elements
//            .map { (current: $0.list?.count ?? 0, pageSize: 18) }
//            .bind(to: output.footerState)
//            .disposed(by: disposeBag)

        /// 返回值 + 当前页面 返回空数据视图状态展示
//        Observable
//            .combineLatest(service.getRecordList.elements, page)
//            .asObservable()
//            .map { (model, page) -> LXEmptyType in
//                if model.list?.count == 0, page == 1 {
//                    return .noData
//                }
//                return .success
//            }
//            .bind(to: output.emptyData)
//            .disposed(by: disposeBag)

        /// 底部刷新 合并 页码 绑定请求
//        input.footerRefresh
//            .withLatestFrom(page)
//            .bind(to: service.getRecordList.inputs)
//            .disposed(by: disposeBag)

        /// 请求错误 + 页码 返回空数据视图展示
//        Observable
//            .combineLatest(service.getRecordList.checkError, page)
//            .asObservable()
//            .map { $1 == 1 ? $0 : .success }
//            .bind(to: output.emptyData)
//            .disposed(by: disposeBag)

        /// 请求错误 返回底部刷新状态
//        service.getRecordList.checkError.hideLoading()
//            .map { _ in (0, 0) }
//            .bind(to: output.footerState)
//            .disposed(by: disposeBag)

        /// 头部刷新 更新页面 绑定请求
//        input.headerRefresh.showLoading()
//            .map { _ in
//                page.onNext(1)
//                return 1
//            }
//            .startWith(1)
//            .bind(to: service.getRecordList.inputs)
//            .disposed(by: disposeBag)

        /// 重试事件
//        input.retry.withLatestFrom(page)
//            .bind(to: service.getRecordList.inputs)
//            .disposed(by: disposeBag)


    }
}

// MARK: 👀Public Actions
extension LXSongVM {}

// MARK: 🔐Private Actions
private extension LXSongVM {}
