//
//  LXWebVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/8.
//
import UIKit
import WebKit

class LXWebVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var topView: UIView = {
        let v = UIView()
        v.backgroundColor = .magenta
        return v
    }()
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let v = WKWebView(frame: .zero, configuration: config)
        if #available(iOS 16.4, *) {
            v.isInspectable = true
        }
        v.tintAdjustmentMode = .dimmed
        v.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        v.scrollView.contentInsetAdjustmentBehavior = .never
        // v.setup()
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        loadData()
    }

}

// MARK: 🌎LoadData
extension LXWebVC {
    func loadData() {
        let urlString =
        // "https://dj.st.bl.com/goodsDetail?goodsId=1013284&tdType=0"
        // "https://dj.st.bl.com/couponApplyList?couponTemplateId=377378007&acquireBuId=2000&myself=true"
        "https://dj.st.bl.com/couponApplyList?channel=IOS&storeCode=007780&storeType=2020&couponTemplateId=370959914&from=dj&bl_ad=20003_-_18709_-_1&memberToken=4acf40fa4a3f2a4100f0b019882e8dd01a77b66e506eaa3a6cb8a5302382acb1"
        if let request = URLRequest(urlString: urlString) {
            webView.load(request)
        }
        // webView.loadHTMLString(mockData(), baseURL: nil)
    }
}

// MARK: 👀Public Actions
extension LXWebVC {}

// MARK: 🔐Private Actions
private extension LXWebVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXWebVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.edgesForExtendedLayout = []
        // self.navigationController?.isNavigationBarHidden = true
        // self.title = "<#title#>"

        [
            // topView,
            webView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        // topView.snp.makeConstraints {
        //     $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        //     $0.left.right.equalToSuperview()
        //     $0.height.equalTo(0)
        // }
        webView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            // $0.top.equalTo(topView.snp_bottomMargin)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
