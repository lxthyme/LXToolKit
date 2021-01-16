//
//  LXPickerVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Photos
//import PhotosUI
//import YPImagePicker

class LXPickerVC: UIViewController {
    // MARK: 📌UI
    private lazy var btnTest: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Test", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.addTarget(self, action: #selector(btnTestAction(sender:)), for: .touchUpInside)
        return btn
    }()
    private lazy var btnAlbum: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Album", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.addTarget(self, action: #selector(btnAlbumAction(sender:)), for: .touchUpInside)
        return btn
    }()
    private lazy var btnYPImagePicker: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("YPImagePicker", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.addTarget(self, action: #selector(btnYPImagePickerAction(sender:)), for: .touchUpInside)
        return btn
    }()
//    private lazy var pickerConfiguration: YPImagePickerConfiguration = {
//        var config = YPImagePickerConfiguration.shared
//        /// 1. General
//        config.isScrollToChangeModesEnabled = true
//        config.onlySquareImagesFromCamera = true
//        config.usesFrontCamera = false
//        config.showsPhotoFilters = true
//        config.showsVideoTrimmer = true
//        config.shouldSaveNewPicturesToAlbum = true
//        config.albumName = "DefaultYPImagePickerAlbumName"
//        config.startOnScreen = YPPickerScreen.photo
//        config.screens = [.library, .photo, .video]
//        config.showsCrop = .none
//        config.targetImageSize = .original
//        config.overlayView = UIView()
//        config.hidesStatusBar = true
//        config.hidesBottomBar = false
//        config.hidesCancelButton = false
//        config.preferredStatusBarStyle = .default
//        config.bottomMenuItemSelectedTextColour = UIColor(red: 38 / 255, green: 38 / 255, blue: 38 / 255, alpha: 1)
//        config.bottomMenuItemUnSelectedTextColour = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
////        config.filters = [DefaultYPFilters...]
//        config.maxCameraZoomFactor = 1.0
//        config.preferredStatusBarStyle = .lightContent
////        config.preSelectItemOnMultipleSelection = true
////        config.fonts..
//
//        /// 2. Library
//        config.library.options = nil
//        config.library.onlySquare = false
//        config.library.isSquareByDefault = true
//        config.library.minWidthForItem = nil
//        config.library.mediaType = .photoAndVideo
//        config.library.defaultMultipleSelection = false
//        config.library.maxNumberOfItems = 3
//        config.library.minNumberOfItems = 1
//        config.library.numberOfItemsInRow = 4
//        config.library.spacingBetweenItems = 1.0
//        config.library.skipSelectionsGallery = false
//        config.library.preselectedItems = nil
//
//        /// 3. Video
//        config.video.compression = AVAssetExportPresetHighestQuality
//        config.video.fileType = .mov
//        config.video.recordingTimeLimit = 60.0
//        config.video.libraryTimeLimit = 60.0
//        config.video.minimumTimeLimit = 3.0
//        config.video.trimmerMaxDuration = 60.0
//        config.video.trimmerMinDuration = 3.0
//
//        /// 4. Gallery
//        config.gallery.hidesRemoveButton = false
//
//        /// 5. wordings
//        config.wordings.albumsTitle = "XAlbums"
//        config.wordings.libraryTitle = "XLibrary"
//        config.wordings.cameraTitle = "XCamera"
//        config.wordings.videoTitle = "XVideo"
//        return config
//    }()
//    private lazy var pickerVC: YPImagePicker = {
//        let picker = YPImagePicker(configuration: pickerConfiguration)
//        picker.didFinishPicking { [weak picker] (list, isCancelled) in
//            dlog("[isCancelled: \(isCancelled) - \(list.count)]: \(list)")
//            if let photo = list.singlePhoto {
//                // Image source (camera or library)
//                dlog("photo.fromCamera: \(photo.fromCamera)",
//                    // Final image selected by the user
//                    "photo.image: \(photo.image)",
//                    // original image selected by the user, unfiltered
//                    "photo.originalImage: \(photo.originalImage)",
//                    // Transformed image, can be nil
//                    "photo.modifiedImage: \(photo.modifiedImage)",
//                    // Print exif meta data of original image.
//                    "photo.exifMeta: \(photo.exifMeta ?? [:])")
//            }
//            picker?.dismiss(animated: true, completion: nil)
//        }
//        return picker
//    }()
    // MARK: 🔗Vaiables
//    private lazy var albumVC: LXPhotoAlbumVC = {
//        let vc = LXPhotoAlbumVC(albumList: LXAlbumListModel(title: <#T##String#>, result: <#T##PHFetchResult<PHAsset>#>, collection: <#T##PHAssetCollection#>, option: <#T##PHFetchOptions#>, isCameraRoll: <#T##Bool#>))
//        return vc
//    }()
    private lazy var albumVC: UIViewController = {
        return UIViewController()
    }()
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        LXPhotoHelper.instance.requestAuthorization(nil)
    }

}

// MARK: 🌎LoadData
extension LXPickerVC {}

// MARK: 👀Public Actions
extension LXPickerVC {}

// MARK: 🔐Private Actions
private extension LXPickerVC {
    @objc func btnTestAction(sender: UIButton) {
//        present(pickerVC, animated: true, completion: nil)
    }
    @objc func btnAlbumAction(sender: UIButton) {
        present(albumVC, animated: true, completion: nil)
    }

    @objc func btnYPImagePickerAction(sender: UIButton) {
        let vc = ExampleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPickerVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        [btnTest, btnAlbum,
         btnYPImagePicker].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
        btnYPImagePicker.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(btnTest.snp.top).offset(8)
        }
        btnAlbum.snp.makeConstraints {
            $0.left.equalTo(btnYPImagePicker.snp.right).offset(8)
            $0.centerY.equalTo(btnYPImagePicker)
        }
        btnTest.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
