//
//  LXHandyJSONTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/7/2.
//
import UIKit
import HandyJSON

class LXHandyJSONTestVC: LXBaseVC {
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

        testFloat()
    }

}

// MARK: 🌎LoadData
extension LXHandyJSONTestVC {}

// MARK: 👀Public Actions
extension LXHandyJSONTestVC {}

// MARK: 🔐Private Actions
private extension LXHandyJSONTestVC {
    func testFloat() {
        /**
         .01, .02, .03, .04, .05, .06, .07, .08, .09,
         .10, .11, .12, .13, .14, .15, .16, .17, .18, .19,
         .30, .31, .32, .33, .34, .35, .36, .37, .38, .39,
         .40, .41, .42, .43, .44, .45, .46, .47, .48, .49,
         .50, .51, .52, .53, .54, .55, .56, .57, .58, .59,
         .60, .61, .62, .63, .64, .65, .66, .67, .68, .69,
         .70, .71, .72, .73, .74, .75, .76, .77, .78, .79,
         .80, .81, .82, .83, .84, .85, .86, .87, .88, .89,
         .91, .90, .93, .92, .95, .94, .97, .96, .99, .98,,
         .100, .101, .102, .103, .104, .105, .106, .107, .108, .109
         */
        let testNumberList = stride(from: 0, to: 100, by: 0.1).compactMap { Float($0) }
        let json: [String: [Float]] = [
            "f1": testNumberList
        ]
        guard let model = LXFloatTestModel.deserialize(from: json) else { return }
        let sum = model.f1?.prefix(3).reduce(0, +)
        dlog("json: \(json)")
        dlog("model: \(model.debugDescription)")
        dlog("sum: \(sum ?? 0)")
    }
}

// MARK: - 🍺UI Prepare & Masonry
// extension LXHandyJSONTestVC {
//     func prepareUI() {
//         self.view.backgroundColor = .white
//         // self.title = "<#title#>"
//
//         // [<#table#>].forEach(self.view.addSubview)
//
//         masonry()
//     }
//
//     func masonry() {}
// }
