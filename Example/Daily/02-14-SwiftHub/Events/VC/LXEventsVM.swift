//
//  LXEventsVM.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

enum EventsMode {
    case repository(repository: Repository)
    case user(user: User)
}

// MARK: - 👀
extension LXEventsVM {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
        let segmentSelection: Observable<EventSegments>
        let selection: Driver<LXEventCellVM>
    }
    struct Output {
        let dataList: BehaviorRelay<[LXEventCellVM]>
        let navTitle: Driver<String>
        let imgUrl: Driver<URL?>
        // let userSelected: Driver<Userv
        // let repoSelected: Driver<
        let hideSegment: Driver<Bool>
    }
    func transform(input: Input) -> Output {
        let dataList = BehaviorRelay<[LXEventCellVM]>(value: [])
        input.headerRefresh
            .flatMapLatest { [weak self] () -> Observable<[LXEventCellVM]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page = 1
                return self.request()
                    .trackActivity(self.headerLoading)
            }
            .subscribe(onNext: {[weak self] item in
                // guard let `self` = self else { return }
                dataList.accept(item)
            })
            .disposed(by: rx.disposeBag)

        input.footerRefresh
            .flatMapLatest {[weak self] () -> Observable<[LXEventCellVM]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page += 1
                return self.request()
                    .trackActivity(self.footerLoading)
            }
            .subscribe(onNext: {[weak self] item in
                // guard let `self` = self else { return }
                dataList.accept(dataList.value + item)
            })
            .disposed(by: rx.disposeBag)

        input.segmentSelection
            .bind(to: segment)
            .disposed(by: rx.disposeBag)

        // let userDetails = userSelected
        //     .asDriver(onErrorJustReturn: User())
        //     .map { User }

        // let repoDetails = input.selection
        //     .map { $0.event.repository }
        //     .filterNil()
        //     .map { Repo }

        let navTitle = mode
            .map { _ in R.string.localizabled.eventsNavigationTitle() }
            .asDriver(onErrorJustReturn: "")
        let imgUrl = mode
            .map { mode -> URL? in
                switch mode {
                case .repository(let repository):
                    return repository.owner?.avatarUrl?.url
                case .user(let user):
                    return user.avatarUrl?.url
                }
            }
            .asDriver(onErrorJustReturn: nil)
        let hideSegment = mode
            .map { mode -> Bool in
                switch mode {
                case .repository(let repository):
                    return true
                case .user(let user):
                    switch user.type {
                    case .organization: return true
                    case .user: return false
                    }
                }
            }
            .asDriver(onErrorJustReturn: false)

        return Output(dataList: dataList, navTitle: navTitle, imgUrl: imgUrl, hideSegment: hideSegment)
    }
}

class LXEventsVM: LXBaseVM, LXViewModelType {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let mode: BehaviorRelay<EventsMode>
    let segment = BehaviorRelay<EventSegments>(value: .received)
    let userSelected = PublishSubject<User>()
    // MARK: 🛠Life Cycle
    init(with mode: EventsMode, provider: API) {
        self.mode = BehaviorRelay(value: mode)
        super.init(provider: provider)
        switch mode {
        case .repository(let repository):
            if let fullname = repository.fullname {
                analytics.log(.repository(fullname: fullname))
            }
        case .user(let user):
            if let login = user.login {
                analytics.log(.user(login: login))
            }
        }
    }

}

// MARK: 👀Public Actions
extension LXEventsVM {}

// MARK: 🔐Private Actions
private extension LXEventsVM {
    func request() -> Observable<[LXEventCellVM]> {
        var request: Single<[Event]>
        switch mode.value {
        case .repository(let repository):
            request = provider.repositoryEvents(owner: repository.owner?.login ?? "", repo: repository.name ?? "", page: page)
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
            .map { $0.map { event in
                let vm = LXEventCellVM(with: event)
                vm.userSelected
                    .bind(to: self.userSelected)
                    .disposed(by: self.rx.disposeBag)
                return vm
            } }
    }
}
