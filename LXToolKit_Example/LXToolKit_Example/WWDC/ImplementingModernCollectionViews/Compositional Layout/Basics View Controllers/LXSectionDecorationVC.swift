//
//  LXSectionDecorationVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit
import LXToolKit

extension LXSectionDecorationVC {
    static let sectionBackgroundDecorationElementKind = "section-background-element-kind"
}

class LXSectionDecorationVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // item.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        // group.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

        let sectionBgDecoration = NSCollectionLayoutDecorationItem.background(elementKind: LXSectionDecorationVC.sectionBackgroundDecorationElementKind)
        sectionBgDecoration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.decorationItems = [sectionBgDecoration]

        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.register(LXSectionBgDecorationView.self, forDecorationViewOfKind: LXSectionDecorationVC.sectionBackgroundDecorationElementKind)
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.delegate = self
        return cv
    }()
    // MARK: 🔗Vaiables
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    var currentSnapshot = NSDiffableDataSourceSnapshot<Int, Int>()
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareCollectionView()
    }

}

// MARK: 🌎LoadData
extension LXSectionDecorationVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXSectionDecorationVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXSectionDecorationVC {
    func generateDataSource() -> UICollectionViewDiffableDataSource<Int, Int> {
        let cellRegistration = UICollectionView.CellRegistration<LXListCell, Int> { cell, indexPath, item in
            let sectionIdentifier = self.currentSnapshot.sectionIdentifiers[indexPath.section]
            let numberOfItemsInSection = self.currentSnapshot.numberOfItems(inSection: sectionIdentifier)
            let isLastCell = indexPath.item + 1 == numberOfItemsInSection
            cell.labTitle.text = "\(indexPath.section), \(indexPath.item)"
            cell.seperatorView.isHidden = isLastCell
        }
        return UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXSectionDecorationVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSectionDecorationVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            dataSource = generateDataSource()
        }
        let itemsPerSection = 5
        let sections = Array(0..<5)
        var itemOffset = 0
        sections.forEach {
            currentSnapshot.appendSections([$0])
            currentSnapshot.appendItems(Array(itemOffset..<itemOffset + itemsPerSection))
            itemOffset += itemsPerSection
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Section Background Decoration View"

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
