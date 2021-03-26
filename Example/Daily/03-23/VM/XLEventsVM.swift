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

enum XLEventsMode {
    case repository(repository: Repository)
    case user(user: User)
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

        input.headerRefresh
            .flatMapLatest {[weak self] _ -> Observable<[XLEventCellVM]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page = 1
                do {
                return try self.request()
                    .trackActivity(self.headerLoading)
                } catch {
                    Logger.error("\(error)")
                }
                return Observable.just([])
            }
//            .subscribe(onNext: {[weak self] items in
//                guard let `self` = self else { return }
//                Logger.debug("🛠1. onNext - headerRefresh: \(items)")
//                elems.accept(items)
//            })
            .subscribe {[weak self] items in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - headerRefresh: \(items)")
                elems.accept(items)
            } onError: {[weak self] error in
                guard let `self` = self else { return }
                dlog("🛠1. onError: \(error)")
            } onCompleted: {
                dlog("🛠2. onCompleted")
            } onDisposed: {
                dlog("🛠3. onDisposed")
            }
            .disposed(by: rx.disposeBag)

        input.footerRefresh
            .flatMapLatest {[weak self] _ -> Observable<[XLEventCellVM]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page += 1
                do {
                return try self.request()
                    .trackActivity(self.footerLoading)
                } catch {
                    Logger.error("\(error)")
                }
                return Observable.just([])
            }
            .subscribe(onNext: {[weak self] items in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - footerRefresh: \(items)")
                elems.accept(elems.value + items)
            })
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
    let userSelected = PublishSubject<User>()
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
    func request() throws -> Observable<[XLEventCellVM]> {
        var request: Single<XLBaseModel<XLBaseListModel<XLEventsModel>>>
        switch mode.value {
            case .repository(let repo):
//                request = provider.repositoryEvents(owner: repo.owner?.login ?? "", repo: repo.name ?? "", page: page)
                request = try provider.userReceivedEvents2(username: "", page: page)
            case .user(let user):
                switch user.type {
                    case .user:
                        switch segment.value {
                            case .performed:
//                                request = provider.userPerformedEvents(username: user.login ?? "", page: page)
                                request = try provider.userReceivedEvents2(username: user.login ?? "", page: page)
                            case .received:
                                request = try provider.userReceivedEvents2(username: user.login ?? "", page: page)
                            break
                        }
                    case .organization:
//                        request = provider.organizationEvents(username: user.login ?? "", page: page)
                        request = try provider.userReceivedEvents2(username: user.login ?? "", page: page)
                    break
                }
        }
        return request
            .trackActivity(loading)
            .trackError(error)
            .map({ baseModel -> [XLEventCellVM] in
                baseModel.data.list.map { m in
                    let vm = XLEventCellVM(event: m)
                    vm.userSelected
                        .bind(to: self.userSelected)
                        .disposed(by: self.rx.disposeBag)
                    return vm
                }
            })
//            .map { $0.map({ event -> XLEventCellVM in
//                let vm = XLEventCellVM(with: event)
//                vm.userSelected
//                    .bind(to: self.userSelected)
//                    .disposed(by: self.rx.disposeBag)
//                return vm
//            })}
    }
    func request2() -> Observable<[XLEventCellVM]> {
        var request: Single<[Event]>
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
            .trackError(error)
            .map { $0.map({ event -> XLEventCellVM in
                let vm = XLEventCellVM(with: event)
                vm.userSelected
                    .bind(to: self.userSelected)
                    .disposed(by: self.rx.disposeBag)
                return vm
            })}
    }
}
