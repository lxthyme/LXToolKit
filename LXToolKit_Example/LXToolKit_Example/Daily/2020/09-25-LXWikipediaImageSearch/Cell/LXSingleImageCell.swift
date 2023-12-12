//
//  LXSingleImageCell.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import RxSwift
import RxCocoa
import SnapKit

class LXSingleImageCell: LXBaseCollectionCell {
    // MARK: 📌UI
    private lazy var imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    var downloadableImage: Observable<DownloadableImage>? {
        didSet {
            // downloadableImage?
            //     .asDriver(onErrorJustReturn: DownloadableImage.offlinePlaceholder)
            //     .drive(imgView.rx.downloadableImageAnimated(.fade))
            //     .disposed(by: self.disposeBag)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
}

// MARK: 👀Public Actions
extension LXSingleImageCell {}

// MARK: 🔐Private Actions
private extension LXSingleImageCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSingleImageCell {
    func prepareUI() {
        [imgView].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
