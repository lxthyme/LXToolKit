//
//  LXCollectionCell.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/9.
//
import UIKit

class LXCollectionCell: UICollectionViewCell {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
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
}

// MARK: 🌎LoadData
extension LXCollectionCell {
    public func dataFill(_ title: String) {
        labTitle.text = title
    }
}

// MARK: 👀Public Actions
extension LXCollectionCell {}

// MARK: 🔐Private Actions
private extension LXCollectionCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXCollectionCell {
    func prepareUI() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.cyan.cgColor
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

        [labTitle].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
