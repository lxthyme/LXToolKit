//
//  DJSwiftTestCaseVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/9/14.
//
import LXToolKit
import Combine

class DJSwiftTestCaseVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension DJSwiftTestCaseVC {}

// MARK: 👀Public Actions
extension DJSwiftTestCaseVC {}

// MARK: 🔐Private Actions
private extension DJSwiftTestCaseVC {
    func testTypePlaceholder() {
        let weiredTuple = (0, 1, Just(1).map(\.description))
        // let result1 = Result<(Int, Int, Publishers.MapKeyPath<Just<Int>, String>), Error>.success(weiredTuple)
        let result2 = Result<_, Error>.success(weiredTuple)
    }
}

// MARK: - 🍺UI Prepare & Masonry
extension DJSwiftTestCaseVC {
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    override func masonry() {
        super.masonry()
    }
}
