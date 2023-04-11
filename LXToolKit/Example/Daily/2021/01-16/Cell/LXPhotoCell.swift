//
//  LXPhotoCell.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXPhotoCell {
    class Photo: UICollectionViewCell {
        // MARK: 📌UI
        private lazy var imgView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            return iv
        }()
        private lazy var coverView: UIView = {
            let v = UIView()
            v.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
            return v
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
    class AddPhoto: UICollectionViewCell {
        // MARK: 📌UI
        private lazy var imgView: UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named: "zl_addPhoto")
            iv.contentMode = .scaleAspectFit
            return iv
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
    class CameraCell: UICollectionViewCell {
        // MARK: 📌UI
        private lazy var imgView: UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named: "zl_takePhoto")
            iv.contentMode = .scaleAspectFit
            return iv
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
}

// MARK: 👀Public Actions
extension LXPhotoCell.Photo {}

// MARK: 🔐Private Actions
private extension LXPhotoCell.Photo {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPhotoCell.Photo {
    func prepareUI() {
        self.contentView.backgroundColor = .white
        [imgView].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {
        imgView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: 👀Public Actions
extension LXPhotoCell.AddPhoto {}

// MARK: 🔐Private Actions
private extension LXPhotoCell.AddPhoto {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPhotoCell.AddPhoto {
    func prepareUI() {
        self.contentView.backgroundColor = UIColor(white: 0.3, alpha: 1)
        [imgView].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {
        imgView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: 👀Public Actions
extension LXPhotoCell.CameraCell {}

// MARK: 🔐Private Actions
private extension LXPhotoCell.CameraCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPhotoCell.CameraCell {
    func prepareUI() {
        self.contentView.backgroundColor = UIColor(white: 0.3, alpha: 1)
        [imgView].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {
        imgView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
