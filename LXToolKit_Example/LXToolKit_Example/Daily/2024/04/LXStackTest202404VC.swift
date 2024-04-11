//
//  LXStackTest202404VC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2024/4/11.
//
import UIKit

class LXStackTest202404VC: LXBaseVC {
    // MARK: 📌UI
    private lazy var wrapperView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    private lazy var wrapperStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.alignment = .lastBaseline
        v.spacing = 5
        // sv.distribution = <#.fillProportionally#>
        return v
    }()
    private lazy var labPrefix: UILabel = {
        let label = UILabel()
        label.text = "到手"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .lightText
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private lazy var labPrice: UILabel = {
        let label = UILabel()
        label.text = "¥289.00"
        label.font = .boldSystemFont(ofSize: 60)
        label.textColor = .black
        label.backgroundColor = .lightText
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXStackTest202404VC {}

// MARK: 👀Public Actions
extension LXStackTest202404VC {}

// MARK: 🔐Private Actions
private extension LXStackTest202404VC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXStackTest202404VC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [labPrefix, labPrice].forEach(wrapperStackView.addArrangedSubview)
        [wrapperView, wrapperStackView].forEach(self.view.addSubview)

        masonry()
        labPrefix.xl.setAllHuggingAndCompressionResistance()
    }

    func masonry() {
        wrapperView.snp.makeConstraints {
            $0.edges.equalTo(self.wrapperStackView)
        }
        wrapperStackView.snp.makeConstraints {
            $0.top.equalTo(200)
            $0.left.equalTo(20)
        }
        // labPrefix.snp.makeConstraints {
        //     $0.firstBaseline.equalTo(self.labPrice)
        // }
    }
}
