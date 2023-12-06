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

// @OptionSet<Int>
// struct LXOptions {
//     private enum OptEnum: Int {
//         case nuts, cherry, fudge
//     }
// }
// @OptionSet
// struct SundaeToppings {
//     private enum Options: Int {
//         case nuts
//         case cherry
//         case fudge
//     }
// }
// MARK: 🔐Private Actions
private extension DJSwiftTestCaseVC {
    func testTypePlaceholder() {
        let weiredTuple = (0, 1, Just(1).map(\.description))
        // let result1 = Result<(Int, Int, Publishers.MapKeyPath<Just<Int>, String>), Error>.success(weiredTuple)
        let result2 = Result<_, Error>.success(weiredTuple)
    }
    func testMacro() {
        print("Currently running \(#function)")
#warning("Something's wrong")
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension DJSwiftTestCaseVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
