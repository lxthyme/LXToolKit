//
//  LXSearchVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/14.
//
import UIKit
import LXToolKit

private typealias Section = String
private typealias Item = Product

// MARK: - 🔐
extension LXSearchVC {
    struct ProductKind {
        static let Ginger = "Ginger"
        static let Gladiolus = "Gladiolus"
        static let Orchid = "Orchid"
        static let Poinsettia = "Poinsettia"
        static let RedRose = "Rose"
        static let GreenRose = "Rose"
        static let Tulip = "Tulip"
        static let RedCarnation = "Carnation"
        static let GreenCarnation = "Carnation"
        static let BlueCarnation = "Carnation"
        static let Sunflower = "Sunflower"
        static let Gardenia = "Gardenia"
        static let RedGardenia = "Gardenia"
        static let BlueGardenia = "Gardenia"
    }
}

class LXSearchVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: resultVC)
        s.searchResultsUpdater = self
        // s.hidesNavigationBarDuringPresentation = false
        // s.automaticallyShowsSearchResultsController = true
        // s.searchBarPlacement = .inline
        s.delegate = self
        s.searchBar.delegate = self
        // s.searchBar.scopeButtonTitles = [
        //     "Scope One",
        //     "Scope Two"
        // ]
        // s.searchSuggestions = []
        s.searchBar.barStyle = .default
        s.searchBar.searchBarStyle = .prominent
        // s.searchBar.showsSearchResultsButton = true
        s.searchBar.autocapitalizationType = .none
        s.searchBar.prompt = "请输入关键字"
        s.searchBar.searchTextField.placeholder = "Enter a search term"
        s.searchBar.returnKeyType = .done
        let inputAssistantItem = UITextInputAssistantItem()
        // s.searchBar.inputAssistantItem.leadingBarButtonGroups = []
        // s.searchBar.inputAssistantItem.trailingBarButtonGroups = []
        s.searchBar.tintColor = .magenta
        s.searchBar.barTintColor = .red
        // s.searchBar.isTranslucent = true
        // s.searchBar.inputAccessoryView
        // s.searchBar.backgroundImage
        // s.searchBar.backgroundColor
        // s.searchBar.searchFieldBackgroundPositionAdjustment = UIOffset(horizontal: 10, vertical: 10)
        // s.searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: 10)
        return s
    }()
    private lazy var resultVC: LXResultVC = {
        let vc = LXResultVC()
        vc.suggestedSearchDelegate = self
        return vc
    }()
    // MARK: 🔗Vaiables
    private var productList: [Product] = []
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    // MARK: 🛠Life Cycle
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        searchController.isActive = true
        dlog("""
        self.presentationController: \(self.presentationController)
        self.presentedViewController: \(self.presentedViewController)
        self.presentingViewController: \(self.presentingViewController)
        """)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()

        dataFill()
    }

}

// MARK: 🌎LoadData
extension LXSearchVC {
    func dataFill() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        productList = [
            Product(title: ProductKind.Ginger, yearIntroduced: dateFormatter.date(from: "2007")!, introPrice: 49.98, color: .undedefined),
            Product(title: ProductKind.Gladiolus, yearIntroduced: dateFormatter.date(from: "2001")!, introPrice: 51.99, color: .undedefined),
            Product(title: ProductKind.Orchid, yearIntroduced: dateFormatter.date(from: "2007")!, introPrice: 16.99, color: .undedefined),
            Product(title: ProductKind.Poinsettia, yearIntroduced: dateFormatter.date(from: "2010")!, introPrice: 31.99, color: .undedefined),
            Product(title: ProductKind.RedRose, yearIntroduced: dateFormatter.date(from: "2010")!, introPrice: 24.99, color: .red),
            Product(title: ProductKind.GreenRose, yearIntroduced: dateFormatter.date(from: "2013")!, introPrice: 24.99, color: .green),
            Product(title: ProductKind.Tulip, yearIntroduced: dateFormatter.date(from: "1997")!, introPrice: 39.99, color: .undedefined),
            Product(title: ProductKind.RedCarnation, yearIntroduced: dateFormatter.date(from: "2006")!, introPrice: 23.99, color: .red),
            Product(title: ProductKind.GreenCarnation, yearIntroduced: dateFormatter.date(from: "2009")!, introPrice: 23.99, color: .green),
            Product(title: ProductKind.BlueCarnation, yearIntroduced: dateFormatter.date(from: "2009")!, introPrice: 24.99, color: .blue),
            Product(title: ProductKind.Sunflower, yearIntroduced: dateFormatter.date(from: "2008")!, introPrice: 25.00, color: .undedefined),
            Product(title: ProductKind.Gardenia, yearIntroduced: dateFormatter.date(from: "2006")!, introPrice: 25.00, color: .undedefined),
            Product(title: ProductKind.RedGardenia, yearIntroduced: dateFormatter.date(from: "2008")!, introPrice: 25.00, color: .red),
            Product(title: ProductKind.BlueGardenia, yearIntroduced: dateFormatter.date(from: "2006")!, introPrice: 25.00, color: .blue)
        ]

        if #available(iOS 14.0, *) {
        let snapshot = generateSnapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: 👀Public Actions
extension LXSearchVC {}

// MARK: 🔐Private Actions
private extension LXSearchVC {
    func setToSuggestedSearches() {
        if searchController.searchBar.searchTextField.tokens.isEmpty {
            // resultVC.show
        }
    }
}

// MARK: - ✈️SuggestedSearchDelegate
extension LXSearchVC: SuggestedSearchDelegate {
    func didSelectSuggestedSearch(token: UISearchToken) {
        if let searchField = navigationItem.searchController?.searchBar.searchTextField {
            searchField.insertToken(token, at: 0)

            resultVC.showSuggestedSearches = false
            updateSearchResults(for: searchController)
        }
    }
    func didSelectProduct(product: Product) {
        let detailVC = LXSearchDetailVC.detailVC(from: product)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - ✈️UISearchResultsUpdating
extension LXSearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let strippedString = searchController.searchBar.text?
            .trimmingCharacters(in: .whitespaces)
            .lowercased() else {
            dlog("searchController.searchBar.text: \(searchController.searchBar.text ?? "")")
            return
        }
        let searchItems = strippedString
            .components(separatedBy: " ")
            .filter { $0.isNotEmpty }
        var filtered: [Product] = if searchItems.isEmpty {
            productList
        } else {
            searchItems.flatMap { keyword in
                productList.filter {
                    $0.title.contains(keyword) ||
                    $0.yearIntroduced.description.contains(keyword) ||
                    $0.introPrice.description.contains(keyword)
                }
            }
        }
        if searchController.searchBar.searchTextField.tokens.isNotEmpty,
           let searchToken = searchController.searchBar.searchTextField.tokens.first,
           let tokenValue = searchToken.representedObject as? NSNumber {
            filtered = filtered.filter { $0.color == tokenValue.intValue }
        }

        if let resultVC = searchController.searchResultsController as? LXResultVC {
            resultVC.filteredProductList = filtered
            resultVC.refreshCollectionView()
        }
    }
    @available(iOS 16.0, *)
    func updateSearchResults(for searchController: UISearchController, selecting searchSuggestion: UISearchSuggestion) {
        dlog("\(#function): \(searchSuggestion)")
    }
}

// MARK: - ✈️UISearchControllerDelegate
extension LXSearchVC: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        searchController.showsSearchResultsController = true
    }
}

// MARK: - ✈️UISearchBarDelegate
extension LXSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let keyword = searchBar.text,
           keyword.isNotEmpty {
            resultVC.showSuggestedSearches = false
        } else {
            resultVC.showSuggestedSearches = true
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true)
        searchBar.text = ""
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.dismiss(animated: true)
    }
}

// MARK: - 🔐
@available(iOS 14.0, *)
private extension LXSearchVC {
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // item.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        // group.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        let section = NSCollectionLayoutSection(group: group)
        // section.interGroupSpacing = <#8.0#>
        // section.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        return UICollectionViewCompositionalLayout(section: section)
    }
    func generateCollectionView() -> UICollectionView {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: generateLayout())
        // cv.backgroundColor = <#.systemGroupedBackground#>
        // cv.delegate = self
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> {[weak self] cell, indexPath, item in
            // cell.labTitle.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.attributedText = NSAttributedString(string: item.title, attributes: [
                .foregroundColor: item.color.suggestedColor
            ])
            contentConfig.secondaryText = "\(item.formattedPrice() ?? "") | \(item.formattedDate() ?? "")"
            cell.contentConfiguration = contentConfig
            cell.accessories = [.disclosureIndicator()]

            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        return UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(["2023"])
        snapshot.appendItems(productList)
        return snapshot
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXSearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


// MARK: - 🍺UI Prepare & Masonry
private extension LXSearchVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
        collectionView = generateCollectionView()
        dataSource = generateDataSource()
        }
        // let snapshot = generateSnapshot()
        // dataSource.apply(snapshot, animatingDifferences: true)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""
        navigationItem.searchController = searchController
        // navigationItem.searchBarPlacement = .stacked
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
