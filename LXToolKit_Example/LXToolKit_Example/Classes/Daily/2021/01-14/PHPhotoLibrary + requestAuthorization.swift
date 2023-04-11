//
//  PHPhotoLibrary + requestAuthorization.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Photos
import PhotosUI
import Toast_Swift

open class LXPhotoHelper: NSObject {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    static let instance = LXPhotoHelper()
    private override init() {}
}

// MARK: - 👀
public extension LXPhotoHelper {
    @discardableResult
    func authorizationStatus(_ presentLimitedLibraryPicker: Bool = false) -> PHAuthorizationStatus {
        if #available(iOS 14, *) {
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            dealResult(status: status, presentLimitedLibraryPicker: presentLimitedLibraryPicker)
            return status
        } else {
            return PHPhotoLibrary.authorizationStatus()
        }
    }
    func requestAuthorization(_ handler: ((PHAuthorizationStatus) -> Void)?) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) {[weak self] status in
                guard let `self` = self else { return }
                handler?(status)
                self.dealResult(status: status)
            }
        } else {
            // Fallback on earlier versions
            PHPhotoLibrary.requestAuthorization {[weak self] status in
                guard let `self` = self else { return }
                handler?(status)
                self.dealResult(status: status)
            }
        }
    }

    @discardableResult
    func limitShow() -> [PHAsset] {
        var list: [PHAsset] = []
        let group = DispatchGroup()
        group.enter()
        dlog("1")
        DispatchQueue.main
            .async(group: group, execute: {
                list = self.f_limitShow()
                group.leave()
            })
        group.wait()
        return list
    }

    @objc func dealLimitedAuth() {
        if #available(iOS 14, *),
           let vc = UIViewController.topViewController() {
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: vc)
        }
    }
}

// MARK: - 👀
public extension LXPhotoHelper {
    @available(iOS 13, *)
    /// PHPhotoLibraryAvailabilityObserver
    /// PHPhotoLibraryChangeObserver
    func register(_ observer: PHPhotoLibraryAvailabilityObserver) {
        PHPhotoLibrary.shared().register(observer)
    }
    @available(iOS 13, *)
    func unregisterAvailabilityObserver(_ observer: PHPhotoLibraryAvailabilityObserver) {
        PHPhotoLibrary.shared().unregisterAvailabilityObserver(observer)
    }
    func register(_ observer: PHPhotoLibraryChangeObserver) {
        PHPhotoLibrary.shared().register(observer)
    }
    func unregisterChangeObserver(_ observer: PHPhotoLibraryChangeObserver) {
        PHPhotoLibrary.shared().unregisterChangeObserver(observer)
    }
}

// MARK: - 🔐
private extension LXPhotoHelper {
    func f_limitShow() -> [PHAsset] {
        let option = PHFetchOptions()
        option.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        var allList: [PHAsset] = []
        PHAsset.fetchAssets(with: .image, options: option)
            .enumerateObjects { (asset, idx, stop) in
                allList.append(asset)
            }

        dlog("[\(allList.count)]allList: \(allList)")
        return allList
    }
    func dealResult(status: PHAuthorizationStatus, presentLimitedLibraryPicker: Bool = false) {
        switch status {
            case .notDetermined:
                dlog("-->notDetermined")
            case .restricted:
                dlog("-->restricted")
            case .denied:
                dlog("-->denied")
            case .authorized:
                dlog("-->authorized")
//                DispatchQueue.main.async {
//                    if #available(iOS 14, *) {
//                        var config = PHPickerConfiguration()
//                        config.filter = PHPickerFilter.images
//                        config.selectionLimit = 0
//                        let pickerVC = PHPickerViewController(configuration: config)
////                    pickerVC.delegate = self
//                        UIViewController.topViewController()?.present(pickerVC, animated: true, completion: nil)
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                }
            case .limited:
                dlog("-->limited")
                if presentLimitedLibraryPicker {
                    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dealLimitedAuth), object: nil)
                    PHPhotoLibrary.shared().perform(#selector(dealLimitedAuth), with: self, afterDelay: 1)
                }
//                var allList: [UIImage] = []
//                let option = PHFetchOptions()
//                option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
//                let result = PHAsset.fetchAssets(with: .image, options: option)
//                result.enumerateObjects { (asset, idx, stop) in
//                    let requestOption = PHImageRequestOptions()
//                    requestOption.resizeMode = .exact
//                    requestOption.deliveryMode = .highQualityFormat
//                    PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: requestOption) { (img, info) in
//                        dlog("img: \(img)")
//                        if let tmp = img {
//                            allList.append(tmp)
//                        }
//                    }
//                }
            @unknown default:
                dlog("-->@unknown default: \(status)")
        }
    }
}
