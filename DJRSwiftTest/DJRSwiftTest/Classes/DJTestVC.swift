//
//  DJTestVC.swift
//  Pods
//
//  Created by lxthyme on 2023/4/1.
//
import UIKit
// import Rswift

class DJTestVC: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
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
    }

}

// MARK: 🌎LoadData
extension DJTestVC {}

// MARK: 👀Public Actions
extension DJTestVC {
    func testM() {
        // let img = R.file
    }
}

// MARK: 🔐Private Actions
private extension DJTestVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension DJTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
