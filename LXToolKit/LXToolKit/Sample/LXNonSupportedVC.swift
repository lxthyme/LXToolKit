//
//  LXNonSupportedVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/23.
//
import UIKit

open class LXNonSupportedVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor.init(hex: 0xeeeeee)
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // MARK: 🔗Vaiables
    var nonSupportTitle: String = "" {
        didSet {
            dlog("nonSupportTitle: \(nonSupportTitle)")
        }
    }
    // MARK: 🛠Life Cycle
    convenience public init(title: String) {
        self.init()
        nonSupportTitle = title
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        labTitle.text = nonSupportTitle
    }

}

// MARK: 🌎LoadData
extension LXNonSupportedVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXNonSupportedVC {}

// MARK: 🔐Private Actions
private extension LXNonSupportedVC {}

// MARK: - 🍺UI Prepare & Masonry
extension LXNonSupportedVC {
    open override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [labTitle].forEach(self.view.addSubview)

        masonry()
    }

    open override func masonry() {
        super.masonry()
        labTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
