//
//  LXSongCellVM.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LXSongCellVM {
    deinit {
        dlog("---------- >>>Model: LXSongCellVM\t\tdeinit <<<----------")
    }
    // MARK: 📌UI
    struct Output {
        lazy var titleText = BehaviorRelay<String>(value: "")
        lazy var contentImage = BehaviorRelay<String>(value: "")
        lazy var dateText = BehaviorRelay<String>(value: "")
        lazy var nameText = BehaviorRelay<String>(value: "")
        lazy var contentImageNormal = BehaviorRelay<String>(value: "")
        lazy var videoUrl = BehaviorRelay<String>(value: "")
        lazy var bgUrl = BehaviorRelay<String>(value: "")
        lazy var navTitle = BehaviorRelay<String>(value: "")
        lazy var songId = BehaviorRelay<String>(value: "")
        lazy var songCoverIsHidden = BehaviorRelay<Bool>(value: true)
    }
    // MARK: 🔗Vaiables
    let disposeBag = DisposeBag()
    var output = Output()
    init(_ item: LXSongRecordItemModel, pageStatus: SongSegmentStatus) {
        Observable
            .just(item.image_url + "?imageView/1/w/744/h/466")
            .bind(to: output.contentImage)
            .disposed(by: disposeBag)
        Observable
            .just(item.name ?? "")
            .bind(to: output.titleText)
            .disposed(by: disposeBag)
        Observable
            .just(item.add_time ?? "")
            .bind(to: output.dateText)
            .disposed(by: disposeBag)
        Observable
            .just(item.nickname ?? "")
            .bind(to: output.nameText)
            .disposed(by: disposeBag)
        Observable
            .just(item.image_url ?? "")
            .bind(to: output.contentImageNormal)
            .disposed(by: disposeBag)
        Observable
            .just(item.video_url ?? "")
            .bind(to: output.videoUrl)
            .disposed(by: disposeBag)
        Observable
            .just(item.bg_video_url ?? "")
            .bind(to: output.bgUrl)
            .disposed(by: disposeBag)
        Observable
            .just(item.name ?? "")
            .bind(to: output.navTitle)
            .disposed(by: disposeBag)
        Observable
            .just(item.kidsong_song_id ?? "")
            .bind(to: output.songId)
            .disposed(by: disposeBag)
        switch pageStatus {
            case .songRecord:
                Observable
                    .just(true)
                    .bind(to: output.songCoverIsHidden)
                    .disposed(by: disposeBag)
            case .songSquare: break
            case .songHistory: break
        }
    }
}

// MARK: 👀Public Actions
extension LXSongCellVM {}

// MARK: 🔐Private Actions
private extension LXSongCellVM {}
