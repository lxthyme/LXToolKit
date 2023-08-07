//
//  DJSearchVM.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit

extension DJSearchVM: LXViewModelType {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
        let languageTrigger: Observable<Void>
        let keywordTrigger: Driver<String>
        let textDidBeginEditing: Driver<Void>
        let languagesSelection: Observable<Void>
        let searchTypeSegmentSelection: Observable<SearchTypeSegments>
        let trengingPeriodSegmentSelection: Observable<TrendingPeriodSegments>
        let searchModeSelection: Observable<SearchModeSegments>
        let sortRepositorySelection: Observable<SortRepositoryItems>
        let sortUserSelection: Observable<SortUserItems>
        let selection: Driver<SearchSectionItem>
    }
    struct Output {
        let items: BehaviorRelay<[SearchSection]>
        let sortItems: Driver<[String]>
        let sortText: Driver<String>
        let totalCountText: Driver<String>
        let textDidBeginEditing: Driver<Void>
        let dismissKeyboard: Driver<Void>
        let languagesSelection: Driver<DJLanguagesVM>
        let repositorySelected: Driver<DJRepositoryCellVM>
        let userSelected: Driver<DJUserCellVM>
        let hidesTrendingPeriodSegment: Driver<Bool>
        let hidesSearchModeSegment: Driver<Bool>
        let hidesSortLabel: Driver<Bool>
    }
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[SearchSection]>(value: [])
        let trendingRepositoryElements = BehaviorRelay<[TrendingRepositoryModel]>(value: [])
        let trendingUserElements = BehaviorRelay<[TrendingUserModel]>(value: [])
        let languageElements = BehaviorRelay<[LanguageModel]>(value: [])
        let repositorySelected = PublishSubject<RepositoryModel>()
        let userSelected = PublishSubject<UserModel>()
        let dismissKeyboard = input.selection.mapToVoid()

        input.searchTypeSegmentSelection
            .bind(to: searchType)
            .disposed(by: rx.disposeBag)
        input.trengingPeriodSegmentSelection
            .bind(to: trendingPeriod)
            .disposed(by: rx.disposeBag)
        input.searchModeSelection
            .bind(to: searchMode)
            .disposed(by: rx.disposeBag)

        input.keywordTrigger
            .skip(1)
            .debounce(.milliseconds(500))
            .distinctUntilChanged()
            .asObservable()
            .bind(to: keyword)
            .disposed(by: rx.disposeBag)

        Observable.combineLatest(keyword, currentLanguage)
            .map { (keyword, currnentLanguage) -> SearchModeSegments in
                return keyword.isEmpty && currnentLanguage != nil ? .trending : .search
            }
            .asObservable()
            .bind(to: searchMode)
            .disposed(by: rx.disposeBag)

        input.sortRepositorySelection
            .bind(to: sortRepositoryItem)
            .disposed(by: rx.disposeBag)
        input.sortUserSelection
            .bind(to: sortUserItem)
            .disposed(by: rx.disposeBag)

        Observable
            .combineLatest(keyword, currentLanguage, sortRepositoryItem)
            .filter { (keyword, currentLanguage, _) -> Bool in
                return keyword.isNotEmpty || currentLanguage != nil
            }
            .flatMapLatest {[weak self] (keyword, currentLanguage, sortRepositoryItem) -> Observable<RxSwift.Event<RepositorySearchModel>> in
                guard let `self` = self else {
                    return Observable.just(RxSwift.Event.next(RepositorySearchModel()))
                }
                self.repositoriesPage = 1
                let query = self.makeQuery()
                let sort = sortRepositoryItem.sortValue
                let order = sortRepositoryItem.orderValue
                return (self.provider as! DJAllAPI).searchRepositories(query: query,
                                                        sort: sort,
                                                        order: order,
                                                        page: self.repositoriesPage,
                                                        endCursor: nil)
                .trackActivity(self.loading)
                .trackActivity(self.headerLoading)
                .trackError(self.error)
                .materialize()
            }
            .subscribe(onNext: {[weak self] event in
                switch event {
                case .next(let result):
                    self?.repositorySearchElements.accept(result)
                default: break
                }
            })
            .disposed(by: rx.disposeBag)

        input.footerRefresh.flatMapLatest {[weak self] () -> Observable<RxSwift.Event<RepositorySearchModel>> in
            guard let `self` = self else {
                return Observable.just(RxSwift.Event.next(RepositorySearchModel()))
            }
            if self.searchMode.value != .search || !self.repositorySearchElements.value.hasNextPage {
                var result = RepositorySearchModel()
                result.totalCount = self.repositorySearchElements.value.totalCount
                return Observable.just(RxSwift.Event.next(result))
                    .trackActivity(self.footerLoading)
            }
            self.repositoriesPage += 1
            let query = self.makeQuery()
            let sort = self.sortRepositoryItem.value.sortValue
            let order = self.sortRepositoryItem.value.orderValue
            let endCursor = self.repositorySearchElements.value.endCursor
            return (self.provider as! DJAllAPI).searchRepositories(query: query,
                                                    sort: sort,
                                                    order: order,
                                                    page: self.repositoriesPage,
                                                    endCursor: endCursor)
            .trackActivity(self.loading)
            .trackActivity(self.footerLoading)
            .trackError(self.error)
            .materialize()
        }
        .subscribe(onNext: {[weak self] event in
            switch event {
            case .next(let result):
                var newResult = result
                newResult.items = (self?.repositorySearchElements.value.items ?? []) + result.items
                self?.repositorySearchElements.accept(newResult)
            default: break
            }
        })
        .disposed(by: rx.disposeBag)

        Observable.combineLatest(keyword, currentLanguage, sortUserItem)
            .filter { (keyword, currentLanguage, _) in
                return keyword.isNotEmpty || currentLanguage != nil
            }
            .flatMapLatest({[weak self] (keyword, currentLanguage, sortUserItem) -> Observable<RxSwift.Event<UserSearchModel>> in
                guard let `self` = self else {
                    return Observable.just(RxSwift.Event.next(UserSearchModel()))
                }
                self.usersPage = 1
                let query = self.makeQuery()
                let sort = sortUserItem.sortValue
                let order = sortUserItem.orderValue
                return (self.provider as! DJAllAPI).searchUsers(query: query,
                                                 sort: sort,
                                                 order: order,
                                                 page: self.usersPage,
                                                 endCursor: nil)
                .trackActivity(self.loading)
                .trackActivity(self.headerLoading)
                .trackError(self.error)
                .materialize()
            })
            .subscribe(onNext: {[weak self] event in
                switch event {
                case .next(let result):
                    self?.userSearchElements.accept(result)
                default: break
                }
            })
            .disposed(by: rx.disposeBag)

        input.footerRefresh.flatMapLatest {[weak self] () -> Observable<RxSwift.Event<UserSearchModel>> in
            guard let `self` = self else {
                return Observable.just(RxSwift.Event.next(UserSearchModel()))
            }
            if self.searchMode.value != .search || !self.userSearchElements.value.hasNextPage {
                var result = UserSearchModel()
                result.totalCount = self.userSearchElements.value.totalCount
                return Observable.just(RxSwift.Event.next(UserSearchModel()))
            }
            self.usersPage += 1
            let query = self.makeQuery()
            let sort = self.sortUserItem.value.sortValue
            let order = self.sortUserItem.value.orderValue
            let endCursor = self.userSearchElements.value.endCursor
            return (self.provider as! DJAllAPI).searchUsers(query: query,
                                             sort: sort,
                                             order: order,
                                             page: self.usersPage,
                                             endCursor: endCursor)
            .trackActivity(self.loading)
            .trackActivity(self.footerLoading)
            .trackError(self.error)
            .materialize()
        }
        .subscribe(onNext: {[weak self] event in
            switch event {
            case .next(let result):
                var newResult = result
                newResult.items = (self?.userSearchElements.value.items ?? []) + result.items
                self?.userSearchElements.accept(newResult)
            default: break
            }
        })
        .disposed(by: rx.disposeBag)

        keyword.asDriver()
            .debounce(.milliseconds(300))
            .filterEmpty()
            .drive(onNext: { keyword in
                // analytics.log
            })
            .disposed(by: rx.disposeBag)

        Observable.just(())
            .flatMapLatest { () -> Observable<[LanguageModel]> in
                return (self.provider as! DJAllAPI).languages()
                    .trackActivity(self.loading)
                    .trackError(self.error)
            }
            .subscribe(onNext: { list in
                languageElements.accept(list)
            }, onError: { error in
                logError(error.localizedDescription)
            })
            .disposed(by: rx.disposeBag)

        let trendingPeriodSegment = BehaviorRelay<TrendingPeriodSegments>(value: .daily)
        input.trengingPeriodSegmentSelection
            .bind(to: trendingPeriodSegment)
            .disposed(by: rx.disposeBag)

        let trendingTrigger = Observable.of(
            input.headerRefresh.skip(1),
            input.trengingPeriodSegmentSelection.mapToVoid(),
            currentLanguage.mapToVoid().skip(1),
            keyword.asObservable()
                .map { $0.isEmpty}
                .filter { $0 == true }
                .mapToVoid()
        )
        .merge()
        trendingTrigger
            .flatMapLatest { () -> Observable<RxSwift.Event<[TrendingRepositoryModel]>> in
                let language = self.currentLanguage.value?.urlParam ?? ""
                let since = trendingPeriodSegment.value.paramValue
                return (self.provider as! DJAllAPI).trendingRepositories(language: language, since: since)
                    .trackActivity(self.loading)
                    .trackActivity(self.headerLoading)
                    .trackError(self.error)
                    .materialize()
            }
            .subscribe(onNext: { event in
                switch event {
                case .next(let list):
                    trendingRepositoryElements.accept(list)
                default: break
                }
            })
            .disposed(by: rx.disposeBag)

        trendingTrigger
            .flatMapLatest {[weak self] () -> Observable<RxSwift.Event<[TrendingUserModel]>> in
                guard let `self` = self else {
                    return Observable.just(RxSwift.Event.next([]))
                }
                let language = self.currentLanguage.value?.urlParam ?? ""
                let since = trendingPeriodSegment.value.paramValue
                return (self.provider as! DJAllAPI).trendingDevelopers(language: language, since: since)
                    .trackActivity(self.loading)
                    .trackActivity(self.headerLoading)
                    .trackError(self.error)
                    .materialize()
            }
            .subscribe(onNext: { event in
                switch event {
                case .next(let  list):
                    trendingUserElements.accept(list)
                default: break
                }
            })
            .disposed(by: rx.disposeBag)

        input.selection
            .drive(onNext: { searchSectionItem in
                switch searchSectionItem {
                case .trendingRepositoriesItem(let cellVM):
                    repositorySelected.onNext(RepositoryModel(repo: cellVM.repository))
                case .trendingUsersItem(let cellVM):
                    userSelected.onNext(UserModel(user: cellVM.user))
                case .repositoriesItem(let cellVM):
                    repositorySelected.onNext(cellVM.repository)
                case .usersItem(let cellVM):
                    userSelected.onNext(cellVM.user)
                }
            })
            .disposed(by: rx.disposeBag)

        Observable.combineLatest(trendingRepositoryElements,
                                 trendingUserElements,
                                 repositorySearchElements,
                                 userSearchElements,
                                 searchType,
                                 searchMode)
        .map {[weak self] (trendingRepositories, trendingUsers, repositories, users, searchType, searchMode) -> [SearchSection] in
            guard let `self` = self else { return [] }
            var elements: [SearchSection] = []
            let language = self.currentLanguage.value?.displayName()
            let since = trendingPeriodSegment.value
            var title = ""
            switch searchMode {
            case .trending:
                title = language != nil ? R.string.localizable.searchTrendingSectionWithLanguageTitle("\(language ?? "")")
                : R.string.localizable.searchTrendingSectionTitle()
            case .search:
                title = language != nil ?
                R.string.localizable.searchSearchSectionWithLanguageTitle("\(language ?? "")")
                : R.string.localizable.searchSearchSectionTitle()
            }

            switch searchType {
            case .repositories:
                switch searchMode {
                case .trending:
                    let repositories = trendingRepositories.map { trendingRepositoryModel -> SearchSectionItem in
                        let cellVM = DJTrendingRepositoryCellVM(repository: trendingRepositoryModel, since: since)
                        return .trendingRepositoriesItem(cellVM: cellVM)
                    }
                    if repositories.isNotEmpty {
                        elements.append(.repositories(title: title, items: repositories))
                    }
                case .search:
                    let repositories = repositories.items.map { repositoryModel -> SearchSectionItem in
                        let cellVM = DJRepositoryCellVM(repository: repositoryModel)
                        return .repositoriesItem(cellVM: cellVM)
                    }
                    if repositories.isNotEmpty {
                        elements.append(.repositories(title: title, items: repositories))
                    }
                }
            case .users:
                switch searchMode {
                case .trending:
                    let users = trendingUsers.map { trendingUserModel -> SearchSectionItem in
                        let cellVM = DJTrendingUserCellVM(user: trendingUserModel)
                        return .trendingUsersItem(cellVM: cellVM)
                    }
                    if users.isNotEmpty {
                        elements.append(.users(title: title, items: users))
                    }
                case .search:
                    let users = users.items.map { userModel -> SearchSectionItem in
                        let cellVM = DJUserCellVM(user: userModel)
                        return .usersItem(cellVM: cellVM)
                    }
                    if users.isNotEmpty {
                        elements.append(.users(title: title, items: users))
                    }
                }
            }
            return elements
        }
        .bind(to: elements)
        .disposed(by: rx.disposeBag)

        let textDidBeginEding = input.textDidBeginEditing

        let repositoryDetails = repositorySelected.map { repositoryModel -> DJRepositoryCellVM in
            let vm = DJRepositoryCellVM(repository: repositoryModel)
            return vm
        }
            .asDriverOnErrorJustComplete()

        let userDetails = userSelected.map { userModel -> DJUserCellVM in
            let vm = DJUserCellVM(user: userModel)
            return vm
        }
            .asDriverOnErrorJustComplete()

        let languageSelection = input.languagesSelection
            .asDriver(onErrorJustReturn: ())
            .map { () -> DJLanguagesVM in
                let vm = DJLanguagesVM(currentLanguage: self.currentLanguage.value, languages: languageElements.value, provider: self.provider as! DJAllAPI)
                vm.currentLanguage.skip(1)
                    .bind(to: self.currentLanguage)
                    .disposed(by: self.rx.disposeBag)
                return vm
            }

        let hidesTrendingPeriodSegment = searchMode
            .map { $0 != .trending }
            .asDriver(onErrorJustReturn: false)

        let hidesSearchModeSegment = Observable.combineLatest(
            input.keywordTrigger
                .asObservable()
                .map { $0.isNotEmpty },
            currentLanguage.map { $0 == nil }
        )
            .map { $0 || $1 }
            .asDriver(onErrorJustReturn: false)

        let hidesSortLabel = searchMode
            .map { $0 == .trending }
            .asDriver(onErrorJustReturn: false)

        let sortItems = Observable.combineLatest(searchType, input.languageTrigger)
            .map { (searchType, _) -> [String] in
                switch searchType {
                case .repositories: return SortRepositoryItems.allItems()
                case .users: return SortUserItems.allItems()
                }
            }
            .asDriver(onErrorJustReturn: [])

        let sortText = Observable
            .combineLatest(searchType, sortRepositoryItem, sortUserItem, input.languageTrigger)
            .map { (searchType, sortRepositoryItems, sortUserItems, _) -> String in
                switch searchType {
                case .repositories: return sortRepositoryItems.title + "▼"
                case .users: return sortUserItems.title + "▼"
                }
            }
            .asDriver(onErrorJustReturn: "")

        let totalCountText = Observable
            .combineLatest(searchType, repositorySearchElements, userSearchElements, input.languageTrigger)
            .map { (searchType, repositorySearchModel, userSearchModel, _) -> String in
                switch searchType {
                case .repositories:
                    return R.string.localizable.searchRepositoriesTotalCountTitle("\(repositorySearchModel.totalCount.kFormatted())")
                case .users:
                    return R.string.localizable.searchUsersTotalCountTitle("\(userSearchModel.totalCount.kFormatted())")
                }
            }
            .asDriver(onErrorJustReturn: "")

        return Output(items: elements,
                      sortItems: sortItems,
                      sortText: sortText,
                      totalCountText: totalCountText,
                      textDidBeginEditing: textDidBeginEding,
                      dismissKeyboard: dismissKeyboard,
                      languagesSelection: languageSelection,
                      repositorySelected: repositoryDetails,
                      userSelected: userDetails,
                      hidesTrendingPeriodSegment: hidesTrendingPeriodSegment,
                      hidesSearchModeSegment: hidesSearchModeSegment,
                      hidesSortLabel: hidesSortLabel)
    }
    func makeQuery() -> String {
        var query = keyword.value
        if let language = currentLanguage.value?.urlParam {
            query += "language:\(language)"
        }
        return query
    }
}

class DJSearchVM: LXBaseVM {
    // MARK: 🔗Vaiables
    let searchType = BehaviorRelay<SearchTypeSegments>(value: .repositories)
    let trendingPeriod = BehaviorRelay<TrendingPeriodSegments>(value: .daily)
    let searchMode = BehaviorRelay<SearchModeSegments>(value: .trending)

    let keyword = BehaviorRelay(value: "")
    let currentLanguage = BehaviorRelay<LanguageModel?>(value: .currentLanguage())
    let sortRepositoryItem = BehaviorRelay<SortRepositoryItems>(value: .bestMatch)
    let sortUserItem = BehaviorRelay<SortUserItems>(value: .bestMatch)

    let repositorySearchElements = BehaviorRelay(value: RepositorySearchModel())
    let userSearchElements = BehaviorRelay(value: UserSearchModel())

    var repositoriesPage = 1
    var usersPage = 1

    // MARK: 🛠Life Cycle
}

// MARK: 👀Public Actions
extension DJSearchVM {}

// MARK: 🔐Private Actions
private extension DJSearchVM {}
