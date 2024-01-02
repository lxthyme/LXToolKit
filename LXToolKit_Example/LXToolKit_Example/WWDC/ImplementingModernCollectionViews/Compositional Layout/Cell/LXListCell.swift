//
//  LXListCell.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit

class LXListCell: UICollectionViewCell {
    // MARK: 📌UI
    private lazy var imgViewAccessory: UIImageView = {
        let iv = UIImageView()
        // iv.image = UIImage(named: "")
        // iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFit

        let rtl = effectiveUserInterfaceLayoutDirection == .rightToLeft
        let chevronImageName = rtl ? "chevron.left" : "chevron.right"
        let chevronImage = UIImage(systemName: chevronImageName)
        iv.image = chevronImage
        iv.tintColor = .lightGray.withAlphaComponent(0.7)
        return iv
    }()
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
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
}

// MARK: 👀Public Actions
extension LXListCell {}

// MARK: 🔐Private Actions
private extension LXListCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXListCell {
    func prepareUI() {
        // self.contentView.backgroundColor = .white
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .lightGray.withAlphaComponent(0.3)

        [seperatorView, labTitle, imgViewAccessory].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10.0)
        }
        imgViewAccessory.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(13)
            $0.height.equalTo(20)
        }
        seperatorView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10.0)
            $0.trailing.equalToSuperview().offset(-10.0)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
