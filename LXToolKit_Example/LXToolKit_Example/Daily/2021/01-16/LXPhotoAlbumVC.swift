//
//  LXPhotoAlbumVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import Photos

private let info = LXPhotosConstraint.self
struct LXPhotosConstraint {
    static let itemPadding: CGFloat = 1
    static let itemWidth: CGFloat = {
        return (LXMacro.Screen.width - 3 * itemPadding) / 4
    }()
}
class LXPhotoAlbumVC: UIViewController {
    // MARK: 📌UI
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = info.itemPadding
        layout.minimumInteritemSpacing = info.itemPadding

        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: info.itemWidth, height: info.itemWidth)
        layout.estimatedItemSize = layout.itemSize
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = .zero
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true
        if #available(iOS 11.0, *) {
            layout.sectionInsetReference = .fromContentInset
        }
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        v.delegate = self
        v.dataSource = self
        // v.prefetchDataSource = self
        // v.dragDelegate = self
        // v.dropDelegate = self
        // v.isPrefetchingEnabled = true

//        v.backgroundColor = .white
        // v.showsHorizontalScrollIndicator = true
        // v.showsVerticalScrollIndicator = true
        // v.alwaysBounceVertical = true
        // v.alwaysBounceHorizontal = true
        // v.allowsMultipleSelection = true

        // let header =  VPLoadingHeader.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(true)
        // })
        // v.mj_header = header
        // let footer = VPAutoLoadingFooter.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(false)
        // })
        // v.mj_footer = footer

        LXPhotoCell.AddPhoto.XL.register(v)
        LXPhotoCell.CameraCell.XL.register(v)
        LXPhotoCell.Photo.XL.register(v)
        return v
    }()
    // MARK: 🔗Vaiables
    private var dataList: [PHAsset] = []
    private var selectedList: [LXAlbumListModel.Photo] = []
    private var showAddPhoto: Bool = true
    private var showCamera: Bool = true
    private var extra: Int {
        if #available(iOS 14, *) {
            return Int.XL.toInt(from: showCamera) + Int.XL.toInt(from: showAddPhoto)
        } else {
            return Int.XL.toInt(from: showCamera)
        }
    }
    private var albumList: LXAlbumListModel
    private var hasTakeANewAsset: Bool = false
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(albumList: LXAlbumListModel) {
        self.albumList = albumList
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        LXPhotoHelper.instance.register(self)
    }

}

// MARK: 🌎LoadData
extension LXPhotoAlbumVC {}

// MARK: 👀Public Actions
extension LXPhotoAlbumVC {}

// MARK: 🔐Private Actions
private extension LXPhotoAlbumVC {}

// MARK: - 👀
extension LXPhotoAlbumVC: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: self.albumList.result) else { return }
        DispatchQueue.main.async {
            self.hasTakeANewAsset = true
            self.albumList.result = changes.fetchResultAfterChanges
            if changes.hasIncrementalChanges {
                self.selectedList
                    .removeAll(where: { changeInstance.changeDetails(for: $0.asset)?.objectWasDeleted == true })
            }
            if !changes.removedObjects.isEmpty ||
                !changes.insertedObjects.isEmpty {
                self.albumList.models.removeAll()
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func loadPhotos() {
        if self.albumList.models.isEmpty {
            DispatchQueue.global().async {
//                self.albumList.refr
            }
        }
    }
}

// MARK: - ✈️UICollectionViewDataSource
extension LXPhotoAlbumVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count + extra
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < dataList.count else {
            if indexPath.row == dataList.count {
                // swiftlint:disable:next force_cast
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LXPhotoCell.AddPhoto.XL.reuseIdentifier, for: indexPath) as! LXPhotoCell.AddPhoto
                // swiftlint:disable:previous force_cast
                return cell
            } else {
                // swiftlint:disable:next force_cast
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LXPhotoCell.CameraCell.XL.reuseIdentifier, for: indexPath) as! LXPhotoCell.CameraCell
                // swiftlint:disable:previous force_cast
                return cell
            }
        }
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LXPhotoCell.Photo.XL.reuseIdentifier, for: indexPath) as! LXPhotoCell.Photo
        // swiftlint:disable:previous force_cast
        return cell
    }
}
// MARK: - ✈️UICollectionViewDelegate
extension LXPhotoAlbumVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard indexPath.row < dataList.count else {
            if indexPath.row == dataList.count {
                LXPhotoHelper.instance.dealLimitedAuth()
            } else {
            }
            return
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPhotoAlbumVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.XL.rgba(red: 160, green: 160, blue: 160, transparency: 0.65)
        // self.title = "<#title#>"

        [collectionView].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
