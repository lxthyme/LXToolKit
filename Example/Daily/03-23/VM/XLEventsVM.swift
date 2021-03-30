//
//  XLEventsVM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import HandyJSON

enum XLEventsMode {
    case repository(repository: XLRepositoryModel)
    case user(user: XLUserModel)
}

// MARK: - 👀
extension XLEventsVM: XLViewModelType {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
        let segmentSelection: Observable<EventSegments>
        let selection: Driver<XLEventCellVM>
    }

    struct Output {
        let navigationTitle: Driver<String>
        let imgURL: Driver<URL?>
        let items: BehaviorRelay<[XLEventCellVM]>
//        let userSelected: Driver<Uservm
//        let repoSelected: Driver<Repo>
        let hidesSegment: Driver<Bool>
    }
    func transform(input: Input) -> Output {
        let elems = BehaviorRelay<[XLEventCellVM]>(value: [])

        input.segmentSelection
            .bind(to: segment)
            .disposed(by: rx.disposeBag)

        let loadHeaderData = input.headerRefresh
            .flatMapLatest {[weak self] _ -> Observable<(Bool, [XLEventCellVM])> in
                guard let `self` = self else { return Observable.just((true, [])) }
                self.page = 1
                let req = self.request()
                    .trackActivity(self.headerLoading)
                return Observable.zip(Observable.just(true), req)
            }
        let loadFooterData = input.footerRefresh
            .flatMapLatest {[weak self] _ -> Observable<(Bool, [XLEventCellVM])> in
                guard let `self` = self else { return Observable.just((false, [])) }
                self.page += 1
                let req = self.request()
                    .trackActivity(self.footerLoading)
                return Observable.zip(Observable.just(false), req)
            }
        Observable
            .merge(loadHeaderData, loadFooterData)
            .subscribe {[weak self] (isRefresh, list) in
                Logger.debug("🛠1. onNext - headerRefresh: \(list)")
                guard let `self` = self else { return }
                if isRefresh {
                    elems.accept(list)
                } else {
                    elems.accept(elems.value + list)
                }
                if self.emptyDataSet.value == nil, elems.value.count <= 0 {
                    self.error.onError(ApiError.nocontent(response: nil))
                }
            }
            .disposed(by: rx.disposeBag)
//        let userDetails = userSelected
//            .asDriver(onErrorJustReturn: User())
//            .map { Userv}

//        let repoDetails = input.selection
//            .map { $0.event.repository }
//            .filterNil()
//            .map { Repo}

        let navTitle = mode.map { mode -> String in
            return R.string.localizabled.eventsNavigationTitle()
        }
        .asDriver(onErrorJustReturn: "")

        let imgURL = mode.map { mode -> URL? in
            switch mode {
            case .repository(let repo):
                return repo.owner?.avatarUrl?.url
            case .user(let user):
                return user.avatarUrl?.url
            }
        }
        .asDriver(onErrorJustReturn: nil)

        let hidesSegment = mode.map { mode -> Bool in
            switch mode {
            case .repository: return true
            case .user(let user):
                switch user.type {
                case .user: return false
                case .organization: return true
                }
            }
        }
        .asDriver(onErrorJustReturn: false)

        return Output(navigationTitle: navTitle,
                      imgURL: imgURL,
                      items: elems,
                      hidesSegment: hidesSegment)
    }
}

class XLEventsVM: XLBaseVM {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let mode: BehaviorRelay<XLEventsMode>
    let segment = BehaviorRelay<EventSegments>(value: .received)
    let userSelected = PublishSubject<XLUserModel>()
    var isNoMore = BehaviorRelay<Bool>(value: false)
    init(with mode: XLEventsMode, provider: XLAPI) {
        self.mode = BehaviorRelay(value: mode)
        super.init(provider: provider)
//        switch mode {
//            case .repository(let repo):
//                if let fullname = repo.fullname {
//                    ana
//                }
//            case .user(let user):
//                if let login = user.login {
//                    ana
//                }
//        }
    }
}

// MARK: 👀Public Actions
extension XLEventsVM {}

// MARK: 🔐Private Actions
private extension XLEventsVM {
    func request() -> Single<[XLEventCellVM]> {
        var request: Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>
        switch mode.value {
        case .repository(let repo):
            request = provider.repositoryEvents(owner: repo.owner?.login ?? "", repo: repo.name ?? "", page: page)
        case .user(let user):
            switch user.type {
            case .user:
                switch segment.value {
                case .performed:
                    request = provider.userPerformedEvents(username: user.login ?? "", page: page)
                case .received:
                    request = provider.userReceivedEvents(username: user.login ?? "", page: page)
                }
            case .organization:
                request = provider.organizationEvents(username: user.login ?? "", page: page)
            }
        }
        return request
            .trackActivity(loading)
            .do(onNext: {[weak self] baseModal in
                guard let `self` = self else { return }
                self.emptyDataSet.accept(nil)
            })
            .map { baseModel -> [XLEventCellVM] in
                self.isNoMore.accept((baseModel.data?.totalPage ?? 0) <= 0)
                return (baseModel.data?.list ?? []).map({ event -> XLEventCellVM in
                    let vm = XLEventCellVM(with: event)
                    vm.userSelected
                        .bind(to: self.userSelected)
                        .disposed(by: self.rx.disposeBag)
                    return vm
                })
            }
            .trackError(error)
            .catchError({ error in
                Logger.error("request: \(error)")
                return Observable.just([])
            })
            .asSingle()
//            .deal([], error)
    }
}
