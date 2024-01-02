//
//  LXOffScreenVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/6.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import SnapKit
import SDWebImage

class LXOffScreenVC: LXBaseVC {
    // MARK: UI
    private lazy var imgViewBG: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "1")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    private lazy var imgViewBG1: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        //        iv.layer.masksToBounds = true
        return iv
    }()
    private lazy var imgViewBG2: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "1")
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        testCornerRadius()
    }

}

// MARK: LoadData
extension LXOffScreenVC {}

// MARK: Public Actions
extension LXOffScreenVC {}

// MARK: Private Actions
private extension LXOffScreenVC {
    func testCornerRadius() {
        if let img = UIImage(named: "1")
        //            let img2 = img.xl_cornerRadius(cornerRadius: CGSize(width: 10, height: 20), roundingCorners: .allCorners, newSize: imgViewBG.frame.size)
        {
            //            imgViewBG1.image = img2
            //                let layer = img.xl_corner(newSize: imgViewBG.frame.size)
            //                imgViewBG1.layer.addSublayer(layer)
            //                imgViewBG1.image = UIImage(named: "1")
            //                imgViewBG1.xl_cornerRadius(roundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 20))
            //                let tmp = UIImage(named: "1")?.xl_imageByRoundCornerRadius(radius: 10, corner: .topLeft, borderWidth: 1, borderLineJoin: .bevel)
            //                imgViewBG1.backgroundColor = .cyan
            //                imgViewBG1.image = tmp
            let tmp = UIImage(named: "1")?
                .sd_resizedImage(with: imgViewBG1.frame.size, scaleMode: .aspectFill)?
                .sd_roundedCornerImage(withRadius: 10, corners: .allCorners, borderWidth: 1, borderColor: nil)
            //                    .xl_resizeImage(with: imgViewBG1.frame.size, scaleMode: .aspectFill)?
            //                    .xl_imageByRoundCornerRadius(radius: 10, corner: .allCorners, borderWidth: 1, borderColor: nil, borderLineJoin: .bevel)
            imgViewBG1.image = tmp
        }
    }
}

// MARK: - UI Prepare & Masonry
private extension LXOffScreenVC {
    func prepareUI() {
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = true
        imgViewBG.snp.setLabel("imgViewBG")
        imgViewBG1.snp.setLabel("imgViewBG1")
        imgViewBG2.snp.setLabel("imgViewBG2")
        [imgViewBG, imgViewBG1, imgViewBG2].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //        imgViewBG.snp.makeConstraints {
        //            $0.edges.equalToSuperview().inset(inset)
        //        }
        imgViewBG.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(inset)
        }
        imgViewBG1.snp.makeConstraints {
            $0.top.equalTo(imgViewBG.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(imgViewBG)
            $0.height.equalTo(imgViewBG)
        }
        imgViewBG2.snp.makeConstraints {
            $0.top.equalTo(imgViewBG1.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(imgViewBG)
            $0.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(imgViewBG)
        }
    }
}
