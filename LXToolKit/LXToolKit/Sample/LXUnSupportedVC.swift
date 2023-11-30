//
//  LXUnSupportedVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/23.
//
import UIKit

open class LXUnSupportedVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = "UnSupported"
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor.primaryDark()
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private lazy var labSubtitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .XL.hex(0xCCCCCC)
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
    }
    open override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        labSubtitle.text = nonSupportTitle
    }
}

// MARK: 🌎LoadData
extension LXUnSupportedVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXUnSupportedVC {}

// MARK: 🔐Private Actions
private extension LXUnSupportedVC {}

// MARK: - 🍺UI Prepare & Masonry
extension LXUnSupportedVC {
    open override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [labTitle, labSubtitle].forEach(self.view.addSubview)

        masonry()
    }

    open override func masonry() {
        super.masonry()
        labTitle.snp.makeConstraints {
            $0.bottom.equalTo(labSubtitle.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        labSubtitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
