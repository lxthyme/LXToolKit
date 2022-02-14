//
//  LXSongRecordCell.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
enum LXSongRecordStatus {
    case record
    case square
    case history
}
class LXSongRecordCell: LXBaseCollectionCell {
    // MARK: 📌UI
    private lazy var wrapperView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 15
        v.layer.masksToBounds = true
        v.backgroundColor = .white
        return v
    }()
    private lazy var imgViewSong: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.xlF4F4F4
        return iv
    }()
    private lazy var imgViewReadedTag: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "egsong_video")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(PingFang: 25, type: .medium)
        label.textColor = UIColor.xl534F4F
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    private lazy var coverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        return v
    }()
    private lazy var labDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(PingFang: 25, type: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    private lazy var labUser: UILabel = {
        let label = UILabel()
        label.font = UIFont(PingFang: 21, type: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    lazy var detaObservable = PublishSubject<LXSongCellVM>()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    var vm: LXSongCellVM?
    var disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)

        detaObservable.bind(to: cellModelHandle).disposed(by: rx.disposeBag)
        prepareUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: 👀Public Actions
extension LXSongRecordCell {


    var cellModelHandle: Binder<LXSongCellVM>{
        return Binder(self){ cell, model in

        }
    }
    func bindResult(_ vm: LXSongCellVM) {
//        if let url = try? vm.output.contentImage.value() {
//            imgViewSong.sd_setImage(
//                with: URL(string: url),
//                placeholderImage: nil,
//                options: [
//                    .lowPriority,
//                    .matchAnimatedImageClass,
//                    .preloadAllFrames,
//                    .progressiveLoad,
//                    .retryFailed],
//                context: nil)
//        }
        vm.output.contentImage
            .bind(to: self.imgViewSong.rx.xl_setImage())
            .disposed(by: disposeBag)
        vm.output.dateText
            .bind(to: self.labDate.rx.text)
            .disposed(by: rx.disposeBag)
        vm.output.nameText
            .bind(to: self.labUser.rx.text)
            .disposed(by: rx.disposeBag)
        vm.output.titleText
            .bind(to: self.labTitle.rx.text)
            .disposed(by: rx.disposeBag)
        vm.output.songCoverIsHidden
            .bind(to: self.coverView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        self.vm = vm
    }
}

// MARK: 🔐Private Actions
private extension LXSongRecordCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSongRecordCell {
    func prepareUI() {
        self.contentView.xl
            .addSubviews(wrapperView, labTitle)
        wrapperView.xl
            .addSubviews(imgViewSong, imgViewReadedTag, coverView)
        coverView.xl
            .addSubviews(labDate, labUser)
        masonry()
    }

    func masonry() {
        wrapperView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        imgViewSong.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imgViewReadedTag.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        labTitle.snp.makeConstraints {
            $0.top.equalTo(wrapperView.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
        coverView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(wrapperView)
            $0.height.equalTo(64)
        }
        labDate.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        labUser.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
}
