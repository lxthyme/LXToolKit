//
//  LXActionSheetTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/9/13.
//
import UIKit

class LXActionSheetTestVC: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()

        showActionSheet()
    }

}

// MARK: 🌎LoadData
extension LXActionSheetTestVC {}

// MARK: 👀Public Actions
extension LXActionSheetTestVC {}

// MARK: 🔐Private Actions
private extension LXActionSheetTestVC {
    func showActionSheet() {
        let detailVC = LXTable0120VC()
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *),
           let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXActionSheetTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}

#Preview("LXActionSheetTestVC") {
    return LXActionSheetTestVC()
}
