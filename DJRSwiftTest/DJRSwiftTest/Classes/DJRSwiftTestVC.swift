//
//  DJRSwiftTestVC.swift
//  Pods
//
//  Created by lxthyme on 2023/4/1.
//
import UIKit
// import Rswift

open class DJRSwiftTestVC: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension DJRSwiftTestVC {}

// MARK: 👀Public Actions
extension DJRSwiftTestVC {
    func testM() {
        // let img = R.file
    }
}

// MARK: 🔐Private Actions
private extension DJRSwiftTestVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension DJRSwiftTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
