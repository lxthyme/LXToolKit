//
//  LXBaseMVVMCollectionCell.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/14.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LXBaseMVVMCollectionCell: UICollectionViewCell {
    // MARK: 📌UI
    private lazy var wrapperView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    lazy var wrapperStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        return v
    }()
    // MARK: 🔗Vaiables
    var cellDisposeBag = DisposeBag()
    
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
        updateUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    func updateUI() {
        setNeedsDisplay()
    }
}

// MARK: 🌎LoadData
extension LXBaseMVVMCollectionCell {
    @objc func bind(to viewModel: LXBaseMVVMTableCellVM) {}
}

// MARK: 👀Public Actions
extension LXBaseMVVMCollectionCell {}

// MARK: 🔐Private Actions
private extension LXBaseMVVMCollectionCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseMVVMCollectionCell {
    func prepareUI() {
        contentView.backgroundColor = .white
        layer.masksToBounds = true
        
        [self.wrapperView].forEach(self.contentView.addSubview)
        [self.wrapperStackView].forEach(self.contentView.addSubview)
        
        masonry()
    }
    
    func masonry() {
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
