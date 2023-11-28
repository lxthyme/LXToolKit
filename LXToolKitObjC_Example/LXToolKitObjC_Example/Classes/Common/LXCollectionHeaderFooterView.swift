//
//  LXCollectionHeaderFooterView.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/13.
//
import UIKit

class LXCollectionHeaderFooterView: UICollectionReusableView {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
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

// MARK: 🌎LoadData
extension LXCollectionHeaderFooterView {
    func dataFill(_ title: String) {
        labTitle.text = title
    }
}

// MARK: 👀Public Actions
extension LXCollectionHeaderFooterView {}

// MARK: 🔐Private Actions
private extension LXCollectionHeaderFooterView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXCollectionHeaderFooterView {
    func prepareUI() {
        // self.backgroundColor = .lightGray
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1

        [labTitle].forEach(self.addSubview)

        masonry()
    }

    func masonry() { 
        labTitle.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
        }
    }
}
