//
//  LX03_08_03VC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/3.
//
import UIKit

class LX03_08_03VC: UIViewController {
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
        testM1()
    }

}

// MARK: 🌎LoadData
extension LX03_08_03VC {}

// MARK: 👀Public Actions
extension LX03_08_03VC {}

// MARK: 🔐Private Actions
private extension LX03_08_03VC {
    func getUserName() async -> String {
        return ""
    }
    func getUserPicture() async -> String {
        return ""
    }
    func updateUI(userName: String, userPicture: String) async {}
    func testM1() {
        async {
            async let userName = getUserName()
            async let userPicture = getUserPicture()

            await updateUI(userName: userName, userPicture: userPicture)
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LX03_08_03VC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
