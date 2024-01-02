//
//  LX0114VC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Photos

class LX0114VC: UIViewController {
    deinit {
        LXPhotoHelper.instance.unregisterChangeObserver(self)
    }
    // MARK: 📌UI
    private lazy var btnTest: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Test", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.addTarget(self, action: #selector(btnTestAction(sender:)), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
//    private lazy var pickerView: UIPickerView = {
//        let v = UIPickerView()
////        v.delegate = self
////        v.dataSource = self
//        v.showsSelectionIndicator = true
//        return v
//    }()
    private lazy var datePicker: UIDatePicker = {
//        let dp: UIDatePicker
//        if #available(iOS 14.0, *) {
//            dp = UIDatePicker(frame: .zero, primaryAction: nil)
//        } else {
//            dp = UIDatePicker()
//        }
        let dp = UIDatePicker()
//        dp.datePickerMode = .dateAndTime
//        dp.locale = Locale(identifier: "en_US")
//        dp.timeZone = .current
//        dp.minimumDate = Date()
//        dp.maximumDate = Date()
//        dp.date = Date()
//        dp.minuteInterval = 1
        dp.backgroundColor = .white
        if #available(iOS 13.4, *) {
            dp.preferredDatePickerStyle = .wheels
        }
//        dp.datePickerStyle = .automatic
        return dp
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        LXPhotoHelper.instance.requestAuthorization(nil)
        LXPhotoHelper.instance.register(self)
    }

}

// MARK: 🌎LoadData
extension LX0114VC {}

// MARK: 👀Public Actions
extension LX0114VC {}

// MARK: 🔐Private Actions
private extension LX0114VC {
    @objc func btnTestAction(sender: UIButton) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
        }
    }
}

// MARK: - 👀PHPhotoLibraryChangeObserver
extension LX0114VC: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        LXPhotoHelper.instance.limitShow()
    }
}

// MARK: - 👀UIPickerViewDataSource
// extension LX0114VC: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 20
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 10
//    }
// }

// MARK: - 👀UIPickerViewDelegate
// extension LX0114VC: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
////        pickerView.select
//    }
// }

// MARK: - 🍺UI Prepare & Masonry
private extension LX0114VC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.red
        // self.title = "<#title#>"

        [
//            datePicker,
            btnTest
        ].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
//        datePicker.snp.makeConstraints {
//            $0.left.right.bottom.equalToSuperview()
//            $0.height.equalTo(200)
//        }
        btnTest.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
