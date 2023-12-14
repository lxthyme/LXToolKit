//
//  LXResultVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/14.
//
import UIKit
import LXToolKit

fileprivate typealias Section = String
fileprivate typealias Item = ResultItem

fileprivate enum ResultItem {
    case suggested(title: String)
    case product(product: Product)
}

// MARK: - 👀
extension ResultItem: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .suggested(let title):
            hasher.combine(title)
        case .product(let product):
            hasher.combine(product.title)
        }
    }
}

protocol SuggestedSearchDelegate: AnyObject {
    func didSelectSuggestedSearch(token: UISearchToken)
    func didSelectProduct(product: Product)
}

class LXResultVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    weak var suggestedSearchDelegate: SuggestedSearchDelegate?
    var filteredProductList: [Product] = []
    static let suggestedSearches = [
        "Red Flowers",
        "Green Flowers",
        "Blue Flowers",
    ]
    var showSuggestedSearches: Bool = true {
        didSet {
            if oldValue != showSuggestedSearches {
                refreshCollectionView()
            }
        }
    }
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
        refreshCollectionView()
    }

}

// MARK: 🌎LoadData
extension LXResultVC {
    func dataFill() {}
    func refreshCollectionView() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(["2023"])
        let list = if showSuggestedSearches {
            LXResultVC.suggestedSearches.map { ResultItem.suggested(title: $0) }
        } else {
            filteredProductList.map { ResultItem.product(product: $0) }
        }
        snapshot.appendItems(list)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: 👀Public Actions
extension LXResultVC {}

// MARK: 🔐Private Actions
private extension LXResultVC {
    func suggestedImage(fromIdx: Int) -> UIImage {
        guard let color = Product.ColorKind(rawValue: fromIdx)?.suggestedColor,
              let img = UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(color) else {
            fatalError()
        }
        return img
    }
    static func suggestedTitle(fromIdx: Int) -> String {
        return suggestedSearches[fromIdx]
    }
    static func searchToken(tokenValue: Int) -> UISearchToken? {
        guard let colorKind = Product.ColorKind(rawValue: tokenValue) else {
            return nil
        }
        let img = UIImage(systemName: "circle.fill")?.withTintColor(colorKind.suggestedColor, renderingMode: .alwaysOriginal)
        let searchToken = UISearchToken(icon: img, text: suggestedTitle(fromIdx: tokenValue))
        searchToken.representedObject = NSNumber(value: colorKind.rawValue)
        return searchToken
    }
}

// MARK: - 🔐
private extension LXResultVC {
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
        cv.delegate = self
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> {[weak self] cell, indexPath, item in
            guard let self else { return }
            // cell.labTitle.text = "\(<#item#>)"
            switch item {
            case .suggested(let title):
                // let title = LXResultVC.suggestedTitle(fromIdx: indexPath.row)
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.attributedText = NSAttributedString(string: title, attributes: [
                    .foregroundColor: UIColor.label,
                ])
                let image = suggestedImage(fromIdx: indexPath.row)
                contentConfig.image = image.withRenderingMode(.alwaysOriginal)
                cell.contentConfiguration = contentConfig
            case .product(let product):
                var contentConfig = cell.defaultContentConfiguration()
                contentConfig.attributedText = NSAttributedString(string: product.title, attributes: [
                    .foregroundColor: product.color.suggestedColor,
                ])
                contentConfig.secondaryText = "\(product.formattedPrice()) | \(product.formattedDate())"
                cell.contentConfiguration = contentConfig
            }

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
        snapshot.appendItems(filteredProductList.map { ResultItem.product(product: $0) })
        return snapshot
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXResultVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let suggestedSearchDelegate else { return }

        if showSuggestedSearches {
            if let token = LXResultVC.searchToken(tokenValue: indexPath.row) {
                suggestedSearchDelegate.didSelectSuggestedSearch(token: token)
            }
        } else {
            if let selectedProduct = dataSource.itemIdentifier(for: indexPath),
               case .product(let product) = selectedProduct {
                suggestedSearchDelegate.didSelectProduct(product: product)
            }
        }
    }
}


// MARK: - 🍺UI Prepare & Masonry
private extension LXResultVC {
    func prepareCollectionView() {
        collectionView = generateCollectionView()
        dataSource = generateDataSource()
        // let snapshot = generateSnapshot()
        // dataSource.apply(snapshot, animatingDifferences: true)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
