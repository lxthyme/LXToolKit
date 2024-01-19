//
//  LXSearchDetailVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2024/1/19.
//
import UIKit
import LXToolKit

class LXSearchDetailVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private lazy var labSubtitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        // label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // MARK: 🔗Vaiables
    var product: Product?
    static let activitySuffix = "detailRestored"
    private static let restoredProductKey = "restoredProduct"
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        assert(product != nil, "Error: a product must be assigned.")
        userActivity = productUserActivity(activityType: vcActivityType())

        if let color = product?.color {
            let textAttributes: [NSAttributedString.Key: AnyObject] = [
                .foregroundColor: color.suggestedColor
            ]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
        title = product?.title
        labTitle.text = product?.formattedDate()
        labSubtitle.text = product?.formattedPrice()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        let textAttributes: [NSAttributedString.Key: AnyObject] = [
            .foregroundColor: UIColor.label,
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        view.window?.windowScene?.userActivity = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXSearchDetailVC {
    class func detailVC(from product: Product) -> UIViewController {
        let vc = LXSearchDetailVC()
        vc.product = product
        return vc
    }
}

// MARK: 👀Public Actions
extension LXSearchDetailVC {
    override func updateUserActivityState(_ activity: NSUserActivity) {
        super.updateUserActivityState(activity)

        if let productDataToArchive = activityUserInfoEntry() {
            dlog("-->updateUserActivityState: \(product)")
            userActivity?.addUserInfoEntries(from: productDataToArchive)
        }
    }
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        product = productFromUserActivity(activity)
        dlog("-->restoreUserActivityState: \(product)")
        super.restoreUserActivityState(activity)
    }
}

// MARK: 🔐Private Actions
private extension LXSearchDetailVC {
    func vcActivityType() -> String {
        let definedAppUserActivities: [String]? = try? LXMacro.InfoPlistKey[.NSUserActivityTypes]
        return definedAppUserActivities?.first(where: { $0.hasSuffix(LXSearchDetailVC.activitySuffix) }) ?? ""
    }
    func activityUserInfoEntry() -> [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(product.self)
            return [LXSearchDetailVC.restoredProductKey: data as Any]
        } catch {
            dlog("-->Error encoding product: \(error)")
        }
        return nil
    }
    func productUserActivity(activityType: String) -> NSUserActivity {
        let userActivity = NSUserActivity(activityType: activityType)
        userActivity.title = title
        userActivity.targetContentIdentifier = title
        if let productDataToArchive = activityUserInfoEntry() {
            userActivity.addUserInfoEntries(from: productDataToArchive)
        }
        return userActivity
    }
    func productFromUserActivity(_ activity: NSUserActivity) -> Product? {
        var product: Product?
        if let userInfo = activity.userInfo,
           let productData = userInfo[LXSearchDetailVC.restoredProductKey] as? Data {
            let decoder = JSONDecoder()
            if let savedProduct = try? decoder.decode(Product.self, from: productData) as Product {
                product = savedProduct
            }
        }
        return product
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSearchDetailVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [labTitle, labSubtitle].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.topMargin).offset(50)
            $0.left.equalToSuperview().offset(15)
        }
        labSubtitle.snp.makeConstraints {
            $0.top.equalTo(labTitle.snp.bottom).offset(10)
            $0.left.equalTo(labTitle)
        }
    }
}
