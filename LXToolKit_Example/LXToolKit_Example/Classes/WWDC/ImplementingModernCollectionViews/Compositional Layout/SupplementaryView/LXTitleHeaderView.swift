//
//  LXTitleHeaderView.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit

class LXTitleHeaderView: UICollectionReusableView {
    // MARK: 📌UI
    lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        // label.textColor = <#.black#>
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: 👀Public Actions
extension LXTitleHeaderView {}

// MARK: 🔐Private Actions
private extension LXTitleHeaderView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTitleHeaderView {
    func prepareUI() {
        // self.backgroundColor = .white

        [labTitle].forEach(self.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10.0)
        }
    }
}
