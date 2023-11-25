//
//  LXAMapTestVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/31.
//
import UIKit
// import MAMapKit

class LXAMapTestVC: UIViewController {
    // MARK: 📌UI
    private lazy var btnAddMap: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Create Map", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.addTarget(self, action: #selector(btnAddMap(sender:)), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
    // var mapList: [MAMapView] = []
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXAMapTestVC {}

// MARK: 👀Public Actions
extension LXAMapTestVC {}

// MARK: 🔐Private Actions
private extension LXAMapTestVC {
    func testM() {
        let img = UIImage(resource: .iconUpvoted)
    }
}

// MARK: 🔐Private Actions
private extension LXAMapTestVC {
    @objc func btnAddMap(sender: UIButton) {
        // let mapView = makeMapView()
        // mapList.append(mapView)
        // 
        // btnAddMap.setTitle("Create Map\(mapList.count)", for: .normal)
    }
    // func makeMapView() -> MAMapView {
    //     let mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    //     return mapView
    // }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXAMapTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [btnAddMap].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        btnAddMap.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(44)
        }
    }
}
