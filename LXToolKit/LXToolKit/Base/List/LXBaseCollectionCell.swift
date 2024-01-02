//
//  LXBaseCollectionCell.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/27.
//

import UIKit
import SnapKit

open class LXBaseCollectionCell: UICollectionViewCell {
    deinit {
        LogKit.traceLifeCycle(.CollectionViewCell, typeName: xl.typeNameString, type: .deinit)
    }
    // MARK: 📌UI
    public lazy var wrapperView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    public lazy var wrapperStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        return v
    }()
    // MARK: 🛠Life Cycle
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
        // LogKit.traceLifeCycle(.TableViewCell, typeName: xl.typeNameString, type: .`init`)
    }
    // MARK: 🔗Vaiables
    override public init(frame: CGRect) {
        super.init(frame: frame)

        basePrepareUI()
        baseMasonry()
    }
}
// MARK: 🌎LoadData
public extension LXBaseCollectionCell {
    @objc open func bind(to viewModel: LXBaseCollectionCellVM) {}
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseCollectionCell {
    func basePrepareUI() {
        contentView.backgroundColor = .white
        layer.masksToBounds = true

        [self.wrapperView].forEach(self.contentView.addSubview)
        [self.wrapperStackView].forEach(self.contentView.addSubview)

    }

    func baseMasonry() {
        self.snp.setLabel("\(xl.typeNameString)")
        contentView.snp.setLabel("\(self.contentView.xl.typeNameString).contentView")
        wrapperView.snp.setLabel("\(self.wrapperView.xl.typeNameString).wrapperView")
        wrapperStackView.snp.setLabel("\(self.wrapperStackView.xl.typeNameString).wrapperStackView")
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        wrapperStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
