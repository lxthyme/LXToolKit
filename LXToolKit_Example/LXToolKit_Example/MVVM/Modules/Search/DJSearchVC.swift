//
//  DJSearchVC.swift
//  test
//
//  Created by lxthyme on 2023/3/24.
//
import UIKit
import HMSegmentedControl
import DropDown
import RxDataSources

// private let trendingRepositoryReuseIdentifier = R.reuseIdentifier.trendingRepositoryCell
// private let trendingUserReuseIdentifier = R.reuseIdentifier.trendingUserCell
// private let repositoryReuseIdentifier = R.reuseIdentifier.repositoryCell
// private let userReuseIdentifier = R.reuseIdentifier.userCell

enum SearchTypeSegments: Int {
    case repositories, users

    var title: String {
        switch self {
        case .repositories: return R.string.localizable.searchRepositoriesSegmentTitle()
        case .users: return R.string.localizable.searchUsersSegmentTitle()
        }
    }
}

enum TrendingPeriodSegments: Int {
    case daily, weekly, montly

    var title: String {
        switch self {
        case .daily: return R.string.localizable.searchDailySegmentTitle()
        case .weekly: return R.string.localizable.searchWeeklySegmentTitle()
        case .montly: return R.string.localizable.searchMonthlySegmentTitle()
        }
    }

    var paramValue: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .montly: return "monthly"
        }
    }
}

enum SearchModeSegments: Int {
    case trending, search

    var title: String {
        switch self {
        case .trending: return R.string.localizable.searchTrendingSegmentTitle()
        case .search: return R.string.localizable.searchSearchSegmentTitle()
        }
    }
}

enum SortRepositoryItems: Int {
    case bestMatch, mostStars, fewestStars, mostForks, fewestForks, recentlyUpdated, lastRecentlyUpdated

    var title: String {
        switch self {
        case .bestMatch: return R.string.localizable.searchSortRepositoriesBestMatchTitle()
        case .mostStars: return R.string.localizable.searchSortRepositoriesMostStarsTitle()
        case .fewestStars: return R.string.localizable.searchSortRepositoriesFewestStarsTitle()
        case .mostForks: return R.string.localizable.searchSortRepositoriesMostForksTitle()
        case .fewestForks: return R.string.localizable.searchSortRepositoriesFewestForksTitle()
        case .recentlyUpdated: return R.string.localizable.searchSortRepositoriesRecentlyUpdatedTitle()
        case .lastRecentlyUpdated: return R.string.localizable.searchSortRepositoriesLastRecentlyUpdatedTitle()
        }
    }

    var sortValue: String {
        switch self {
        case .bestMatch: return ""
        case .mostStars, .fewestStars: return "stars"
        case .mostForks, .fewestForks: return "forks"
        case .recentlyUpdated, .lastRecentlyUpdated: return "updated"
        }
    }

    var orderValue: String {
        switch self {
        case .bestMatch: return ""
        case .mostStars, .mostForks, .recentlyUpdated: return "desc"
        case .fewestStars, .fewestForks, .lastRecentlyUpdated: return "asc"
        }
    }

    static func allItems() -> [String] {
        return (0...SortRepositoryItems.lastRecentlyUpdated.rawValue)
            .map { SortRepositoryItems(rawValue: $0)!.title }
    }
}

enum SortUserItems: Int {
    case bestMatch, mostFollowers, fewestFollowers, mostRecentlyJoined, leastRecentlyJoined, mostRepositories, fewestRepositories

    var title: String {
        switch self {
        case .bestMatch: return R.string.localizable.searchSortUsersBestMatchTitle()
        case .mostFollowers: return R.string.localizable.searchSortUsersMostFollowersTitle()
        case .fewestFollowers: return R.string.localizable.searchSortUsersFewestFollowersTitle()
        case .mostRecentlyJoined: return R.string.localizable.searchSortUsersMostRecentlyJoinedTitle()
        case .leastRecentlyJoined: return R.string.localizable.searchSortUsersLeastRecentlyJoinedTitle()
        case .mostRepositories: return R.string.localizable.searchSortUsersMostRepositoriesTitle()
        case .fewestRepositories: return R.string.localizable.searchSortUsersFewestRepositoriesTitle()
        }
    }

    var sortValue: String {
        switch self {
        case .bestMatch: return ""
        case .mostFollowers, .fewestFollowers: return "followers"
        case .mostRecentlyJoined, .leastRecentlyJoined: return "joined"
        case .mostRepositories, .fewestRepositories: return "repositories"
        }
    }

    var orderValue: String {
        switch self {
        case .bestMatch, .mostFollowers, .mostRecentlyJoined, .mostRepositories: return "desc"
        case .fewestFollowers, .leastRecentlyJoined, .fewestRepositories: return "asc"
        }
    }

    static func allItems() -> [String] {
        return (0...SortUserItems.fewestRepositories.rawValue)
            .map { SortUserItems(rawValue: $0)!.title }
    }
}

class DJSearchVC: LXBaseTableVC {
    // MARK: 📌UI
    lazy var rightBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: R.image.icon_navigation_language(),
                                   style: .done,
                                   target: nil,
                                   action: nil)
        return item
    }()
    lazy var segmentedControl: LXHMSegmentedControl = {
        let titles: [SearchTypeSegments] = [.repositories, .users]
        let images = [
            R.image.icon_cell_badge_repository()!,
            R.image.icon_cell_badge_user()!
        ]
        let selectedImages = [
            R.image.icon_cell_badge_repository()!,
            R.image.icon_cell_badge_user()!
        ]
        let v = LXHMSegmentedControl(sectionImages: images,
                                     sectionSelectedImages: selectedImages,
                                     titlesForSections: titles.map { $0.title })
        v.selectedSegmentIndex = 0
        v.prepareVM()
        v.snp.makeConstraints {
            $0.width.equalTo(220)
            $0.height.equalTo(AppConfig.BaseDimensions.segmentedControlHeight)
        }
        return v
    }()
    let trendingPeriodView = UIView()
    lazy var trendingPeriodSegmentedControl: LXHMSegmentedControl = {
        let items: [TrendingPeriodSegments] = [.daily, .weekly, .montly]
        let v = LXHMSegmentedControl(sectionTitles: items.map { $0.title })
        v.selectedSegmentIndex = 0
        v.prepareVM()
        return v
    }()
    let searchModeView = UIView()
    lazy var searchModeSegmentedControl: LXHMSegmentedControl = {
        let titles: [SearchModeSegments] = [.trending, .search]
        let images = [R.image.icon_cell_badge_trending()!,
                      R.image.icon_cell_badge_search()!]
        let selectedImages = [R.image.icon_cell_badge_trending()!,
                              R.image.icon_cell_badge_search()!]
        let v = LXHMSegmentedControl(sectionImages: images,
                                     sectionSelectedImages: selectedImages,
                                     titlesForSections: titles.map { $0.title })
        v.selectedSegmentIndex = 0
        v.prepareVM()
        return v
    }()
    lazy var labTotalCount: LXBaseLabel = {
        let lab = LXBaseLabel()
        lab.font = .systemFont(ofSize: 14)
        lab.textAlignment = .right
        lab.rightTextInset = self.inset
        return lab
    }()
    private lazy var labSort: LXBaseLabel = {
        let label = LXBaseLabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.rightTextInset = self.inset
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [self.labTotalCount, self.labSort])
        v.axis = .horizontal
        return v
    }()
    lazy var dropDownSort: DropDown = {
        let v = DropDown(anchorView: self.table)
        v.selectionAction = {[weak self] (idx, item) in
            if self?.segmentedControl.selectedSegmentIndex == 0 {
                if let item = SortRepositoryItems(rawValue: idx) {
                    self?.sortRepositoryItem.accept(item)
                }
            } else {
                if let item = SortUserItems(rawValue: idx) {
                    self?.sortUserItem.accept(item)
                }
            }
        }
        return v
    }()
    // MARK: 🔗Vaiables
    let sortRepositoryItem = BehaviorRelay(value: SortRepositoryItems.bestMatch)
    let sortUserItem = BehaviorRelay(value: SortUserItems.bestMatch)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareTableView()
        prepareVM()
        bindViewModel()
    }
}

// MARK: 🌎LoadData
extension DJSearchVC {
    override open func bindViewModel() {
        super.bindViewModel()
        guard let vm = vm as? DJSearchVM else { return }

        let searchTypeSegmentSelected = segmentedControl.segmentSelection
            .map { SearchTypeSegments(rawValue: $0)! }
        let trendingPeriodSegmentSelected = trendingPeriodSegmentedControl.segmentSelection
            .map { TrendingPeriodSegments(rawValue: $0)! }
        let searchModeSegmentSelected = searchModeSegmentedControl.segmentSelection
            .map { SearchModeSegments(rawValue: $0)! }
        let refresh = Observable.of(Observable.just(()),
                                    headerRefreshTrigger,
                                    themeService.typeStream.mapToVoid())
            .merge()

        let input = DJSearchVM.Input(headerRefresh: refresh,
                                     footerRefresh: footerRefreshTrigger,
                                     languageTrigger: languageChanged.asObservable(),
                                     keywordTrigger: searchBar.rx.text.orEmpty.asDriver(),
                                     textDidBeginEditing: searchBar.rx.textDidBeginEditing.asDriver(),
                                     languagesSelection: rightBarButton.rx.tap.asObservable(),
                                     searchTypeSegmentSelection: searchTypeSegmentSelected,
                                     trengingPeriodSegmentSelection: trendingPeriodSegmentSelected,
                                     searchModeSelection: searchModeSegmentSelected,
                                     sortRepositorySelection: sortRepositoryItem.asObservable(),
                                     sortUserSelection: sortUserItem.asObservable(),
                                     selection: table.rx.modelSelected(SearchSectionItem.self).asDriver())
        let output = vm.transform(input: input)

        let dataSource = RxTableViewSectionedReloadDataSource<SearchSection>(configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case .trendingRepositoriesItem(let cellVM):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingRepositoryCell.trendingRepositoriesItem", for: indexPath) as? DJSearchDefaultCell
                cell?.bind(to: cellVM)
                return cell!
            case .trendingUsersItem(let cellVM):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingRepositoryCell.trendingUsersItem", for: indexPath) as? DJSearchDefaultCell
                cell?.bind(to: cellVM)
                return cell!
            case .repositoriesItem(let cellVM):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingRepositoryCell.repositoriesItem", for: indexPath) as? DJRepositoryCell
                cell?.bind(to: cellVM)
                return cell!
            case .usersItem(let cellVM):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingRepositoryCell.usersItem", for: indexPath) as? DJSearchDefaultCell
                cell?.bind(to: cellVM)
                return cell!
            }
        }, titleForFooterInSection: { dataSource, index in
            let section = dataSource[index]
            return section.title
        })

        output.items.asObservable()
            .bind(to: table.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.languagesSelection
            .drive {[weak self] vm in
                // self?.navigator.show(segue: .lang, sender: <#T##UIViewController?#>)
            }
            .disposed(by: rx.disposeBag)
        output.repositorySelected
            .drive(onNext: {[weak self] vm in
                // self?.navigator.show(segue: .repo, sender: <#T##UIViewController?#>)
            })
            .disposed(by: rx.disposeBag)
        output.userSelected
            .drive(onNext: {[weak self] vm in
                // self?.navigator.show(segue: .user, sender: <#T##UIViewController?#>)
            })
            .disposed(by: rx.disposeBag)
        output.dismissKeyboard
            .drive(onNext: {[weak self] () in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: rx.disposeBag)

        output.hidesTrendingPeriodSegment
            .drive(trendingPeriodView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        output.hidesSearchModeSegment
            .drive(searchModeView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        output.hidesSortLabel
            .drive(labelsStackView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        output.hidesSortLabel
            .drive(labTotalCount.rx.isHidden)
            .disposed(by: rx.disposeBag)
        output.hidesSortLabel
            .drive(labSort.rx.isHidden)
            .disposed(by: rx.disposeBag)

        labSort.rx.tap()
            .subscribe(onNext: {[weak self] () in
                self?.dropDownSort.show()
            })
            .disposed(by: rx.disposeBag)

        output.sortItems
            .drive(onNext: {[weak self] list in
                self?.dropDownSort.dataSource = list
                self?.dropDownSort.reloadAllComponents()
            })
            .disposed(by: rx.disposeBag)

        output.totalCountText
            .drive(labTotalCount.rx.text)
            .disposed(by: rx.disposeBag)
        output.sortText
            .drive(labSort.rx.text)
            .disposed(by: rx.disposeBag)

        vm.searchMode.asDriver()
            .drive(onNext: {[weak self] searchMode in
                guard let `self` = self else { return }
                self.searchModeSegmentedControl.selectedSegmentIndex = UInt(searchMode.rawValue)

                switch searchMode {
                case .trending:
                    self.table.footRefreshControl = nil
                case .search:
                    self.table.bindGlobalStyle(forFootRefreshHandler: {[weak self] in
                        self?.footerRefreshTrigger.onNext(())
                    })
                    self.table.footRefreshControl.autoRefreshOnFoot = true
                    self.isFooterLoading
                        .bind(to: self.table.footRefreshControl.rx.isAnimating)
                        .disposed(by: self.rx.disposeBag)
                }
            })
            .disposed(by: rx.disposeBag)

    }
}

// MARK: 👀Public Actions
extension DJSearchVC {}

// MARK: 🔐Private Actions
private extension DJSearchVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension DJSearchVC {
    func prepareTableView() {
        table.backgroundColor = .clear
        table.register(DJSearchDefaultCell.self, forCellReuseIdentifier: "TrendingRepositoryCell.trendingRepositoriesItem")
        table.register(DJSearchDefaultCell.self, forCellReuseIdentifier: "TrendingRepositoryCell.trendingUsersItem")
        table.register(DJRepositoryCell.self, forCellReuseIdentifier: "TrendingRepositoryCell.repositoriesItem")
        table.register(DJUserCell.self, forCellReuseIdentifier: "TrendingRepositoryCell.usersItem")
    }
    func prepareVM() {
        languageChanged.subscribe(onNext: {[weak self] () in
            self?.searchBar.placeholder = R.string.localizable.searchSearchBarPlaceholder()
            let searchTypeSegments: [SearchTypeSegments] = [.repositories, .users]
            let trendingPeriodSegments: [TrendingPeriodSegments] = [.daily, .weekly, .montly]
            let searchModeSegments: [SearchModeSegments] = [.trending, .search]
            self?.segmentedControl.sectionTitles = searchTypeSegments.map { $0.title }
            self?.trendingPeriodSegmentedControl.sectionTitles = trendingPeriodSegments.map { $0.title }
            self?.searchModeSegmentedControl.sectionTitles = searchModeSegments.map { $0.title }
        })
        .disposed(by: rx.disposeBag)

        labTotalCount.theme.textColor = themeService.attribute { $0.text }
        labSort.theme.textColor = themeService.attribute { $0.text }

        themeService.typeStream
            .subscribe(onNext: {[weak self] themeType in
                let theme = themeType.associatedObject
                self?.dropDownSort.dimmedBackgroundColor = theme.primaryDark.withAlphaComponent(0.5)

                self?.segmentedControl.sectionImages = [
                    R.image.icon_cell_badge_repository()?
                        .tint(theme.textGray, blendMode: .normal)
                        .withRoundedCorners(),
                    R.image.icon_cell_badge_user()?
                        .tint(theme.textGray, blendMode: .normal)
                        .withRoundedCorners()
                ].compactMap { $0 }
                self?.segmentedControl.sectionSelectedImages = [
                    R.image.icon_cell_badge_repository()?
                        .tint(theme.secondary, blendMode: .normal)
                        .withRoundedCorners(),
                    R.image.icon_cell_badge_user()?
                        .tint(theme.secondary, blendMode: .normal)
                        .withRoundedCorners()
                ].compactMap { $0 }
                self?.searchModeSegmentedControl.sectionImages = [
                    R.image.icon_cell_badge_trending()?
                        .tint(theme.textGray, blendMode: .normal)
                        .withRoundedCorners(),
                    R.image.icon_cell_badge_search()?
                        .tint(theme.textGray, blendMode: .normal)
                        .withRoundedCorners()
                ].compactMap { $0 }
                self?.searchModeSegmentedControl.sectionSelectedImages = [
                    R.image.icon_cell_badge_trending()?
                        .tint(theme.secondary, blendMode: .normal).withRoundedCorners(),
                    R.image.icon_cell_badge_search()?
                        .tint(theme.secondary, blendMode: .normal).withRoundedCorners()
                ].compactMap { $0 }
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {
        // self.view.backgroundColor = .white
        navigationItem.titleView = segmentedControl
        navigationItem.rightBarButtonItem = rightBarButton
        if #available(iOS 14.0, *) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                systemItem: .close,
                primaryAction: UIAction(handler: { _ in
                    Application.shared.dismissPreviousVC()
                })
            )
        }
        contentStackView.axis = .vertical

        trendingPeriodView.addSubview(trendingPeriodSegmentedControl)
        searchModeView.addSubview(searchModeSegmentedControl)

        [searchModeView, searchBar, trendingPeriodView, labelsStackView, table].forEach(self.contentStackView.addArrangedSubview)

        masonry()
    }

    func masonry() {
        trendingPeriodSegmentedControl.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(self.inset)
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(AppConfig.BaseDimensions.segmentedControlHeight)
        }
        searchModeSegmentedControl.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(self.inset)
            $0.height.equalTo(AppConfig.BaseDimensions.segmentedControlHeight)
        }
        labelsStackView.snp.makeConstraints {
            $0.height.equalTo(30)
        }
    }
}
