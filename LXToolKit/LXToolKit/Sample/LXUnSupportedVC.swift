//
//  LXUnSupportedVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/23.
//
import UIKit

open class LXUnSupportedVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var labSubtitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor.primaryDark()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private lazy var labMsg: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .XL.hex(0xCCCCCC)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // MARK: 🔗Vaiables
    public var subtitle: String = "UnSupported" {
        didSet {
            labSubtitle.text = subtitle
        }
    }
    public var msg: String = "" {
        didSet {
            labMsg.text = msg
        }
    }
    // MARK: 🛠Life Cycle
    convenience public init(title: String = "UnSupported", msg: String) {
        self.init()
        self.title = title
        self.msg = msg
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        labSubtitle.text = subtitle
        labMsg.text = msg
    }
    open override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
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
private extension LXUnSupportedVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [labSubtitle, labMsg].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        labSubtitle.snp.makeConstraints {
            $0.left.greaterThanOrEqualToSuperview().offset(20)
            $0.right.lessThanOrEqualToSuperview().offset(-20)
            $0.top.equalTo(self.view.snp.topMargin).offset(20)
            $0.centerX.equalToSuperview()
        }
        labMsg.snp.makeConstraints {
            $0.top.equalTo(labSubtitle.snp.bottom).offset(10)
            $0.left.greaterThanOrEqualToSuperview().offset(20)
            $0.right.lessThanOrEqualToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
    }
}
