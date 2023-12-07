//
//  LXCustomCellListVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/11.
//
import UIKit
import LXToolKit

extension LXCustomCellListVC {
    enum Section {
        case main
    }

    struct Category: Hashable {
        let icon: UIImage?
        let name: String?

        static let music = Category(icon: UIImage(systemName: "music.mic"), name: "Music")
        static let transportation = Category(icon: UIImage(systemName: "car"), name: "Transportation")
        static let weather = Category(icon: UIImage(systemName: "cloud.rain"), name: "Weather")
    }

    struct Item: Hashable {
        private let identifier = UUID()
        let category: Category
        let image: UIImage?
        let title: String?
        let description: String?
        init(category: Category, imageName: String? = nil, title: String? = nil, description: String? = nil) {
            self.category = category
            if let imageName {
                self.image = UIImage(systemName: imageName)
            } else {
                self.image = nil
            }
            self.title = title
            self.description = description
        }

        static let all = [
            Item(category: .music, imageName: "headphones", title: "Headphones",
                 description: "A portable pair of earphones that are used to listen to music and other forms of audio."),
            Item(category: .music, imageName: "hifispeaker.fill", title: "Loudspeaker",
                 description: "A device used to reproduce sound by converting electrical impulses into audio waves."),
            Item(category: .transportation, imageName: "airplane", title: "Plane",
                 description: "A commercial airliner used for long distance travel."),
            Item(category: .transportation, imageName: "tram.fill", title: "Tram",
                 description: "A trolley car used as public transport in cities."),
            Item(category: .transportation, imageName: "car.fill", title: "Car",
                 description: "A personal vehicle with four wheels that is able to carry a small number of people."),
            Item(category: .weather, imageName: "hurricane", title: "Hurricane",
                 description: "A tropical cyclone in the Caribbean with violent wind."),
            Item(category: .weather, imageName: "tornado", title: "Tornado",
                 description: "A destructive vortex of swirling violent winds that advances beneath a large storm system."),
            Item(category: .weather, imageName: "tropicalstorm", title: "Tropical Storm",
                 description: "A localized, intense low-pressure system, forming over tropical oceans."),
            Item(category: .weather, imageName: "snow", title: "Snow",
                 description: "Atmospheric water vapor frozen into ice crystals falling in light flakes.")
        ]
    }
}

class LXCustomCellListVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        // cv.backgroundColor = <#.systemBackground#>
        cv.delegate = self
        return cv
    }()
    // MARK: 🔗Vaiables
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let cellRegistration = UICollectionView.CellRegistration<LXCustomListCell, Item> { cell, indexPath, item in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        return UICollectionViewDiffableDataSource<Section, LXCustomCellListVC.Item>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }()
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
        prepareUI()
        prepareSnapshot()
    }

}

// MARK: 🌎LoadData
extension LXCustomCellListVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXCustomCellListVC {}

// MARK: 🔐Private Actions
private extension LXCustomCellListVC {}

// MARK: - ✈️UICollectionViewDelegate
extension LXCustomCellListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


// MARK: - 🍺UI Prepare & Masonry
private extension LXCustomCellListVC {
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Item.all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "List with Custom Cells"

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
