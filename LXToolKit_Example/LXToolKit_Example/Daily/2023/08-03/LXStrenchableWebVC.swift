//
//  LXStrenchableWebVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2023/3/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//
import UIKit
import SnapKit

// extension Reactive where Base: LXStrenchableWebView {
//     var webViewHeightSubject: Binder<CGFloat> {
//         return Binder(self) { webView, height in
//             webView.
//         }
//     }
// }

class LXStrenchableWebVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var webView: LXStrenchableWebView = {
        let v = LXStrenchableWebView(frame: .zero)
        v.setup()
        return v
    }()
    private lazy var btnTest: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .cyan
        btn.setTitle("Test", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4
        
        // btn.addTarget(self, action: #selector(<#btnAction(sender:)#>), for: .touchUpInside)
        // @objc func <#btnAction#>(sender: UIButton) {}
        return btn
    }()
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
        prepareVM()
        loadData()
    }
}

// MARK: 🌎LoadData
extension LXStrenchableWebVC {
    func loadData() {
        // if let request = URLRequest(urlString: "https://www.baidu.com") {
        //     webView.load(request)
        // }
        webView.loadHTMLString(mockData(), baseURL: nil)
    }
}

// MARK: 👀Public Actions
extension LXStrenchableWebVC {
    func test() {
        // let tf = TextField()
        // let subject = BehaviorRelay<CGFloat>(value: 0)
        // subject.bind(to: webView.rx.webViewHeight)
        // subject.bind { <#CGFloat#> in
        //     <#code#>
        // }
        
        // webView.rx.webViewHeight.asObserver().bi
        // subject.bind(to: webView.rx.webViewHeight)
        // webView.rx.webViewHeight
        // webView.webViewHeight
        //     .asObserver()
        // .asObservable()
    }
}

// MARK: - 🍺UI Prepare & Masonry
extension LXStrenchableWebVC {
    override open func prepareVM() {
        super.prepareVM()
        btnTest.rx
            .controlEvent(.touchUpInside)
            .subscribe {[weak self] _ in
                guard let `self` = self else { return }
                dlog("-->webViewHeight: \(self.webView.webViewHeight)")
            }
            .disposed(by: rx.disposeBag)
        webView.rx
            .observe(\.webViewHeight)
            .debug("-->[WH]: ")
        // .observe(CGFloat.self, "webViewHeight")
            .subscribe { height in
                dlog("height: \(height)")
            }
            .disposed(by: rx.disposeBag)
    }
    override open func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // self.title = "<#title#>"
        
        [webView, btnTest].forEach(self.view.addSubview)
        
        masonry()
    }
    
    override open func masonry() {
        super.masonry()
        webView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalTo(0)
            $0.height.greaterThanOrEqualTo(200)
        }
        btnTest.snp.makeConstraints {
            $0.top.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.width.equalTo(100)
        }
    }
}

// MARK: 🔐Private Actions
private extension LXStrenchableWebVC {
    func mockData() ->String {
        return """
        <style type=\"text/css\">img{display:block;width:100%;height:auto;}</style><img style=\"width:100%;height:auto\" src='http://img.iblimg.com/fast2home-1/offlinegoods/desc/DESC_472741848.jpg' /> <img style=\"width:100%;height:auto\" src='http://img.iblimg.com/fast2home-1/offlinegoods/desc/DESC_1552278410.jpg' /> <img style=\"width:100%;height:auto\" src='http://img.iblimg.com/fast2home-1/offlinegoods/desc/DESC_1594069036.jpg' /><script type=\"text/javascript\">!function(){var t=document.getElementsByTagName(\"table\");if(t&&t.length){var e=[],n=!0,r=!1,a=void 0;try{for(var i,o=t[Symbol.iterator]();!(n=(i=o.next()).done);n=!0){var l=i.value;e.push(l.offsetWidth)}}catch(t){r=!0,a=t}finally{try{!n&&o.return&&o.return()}finally{if(r)throw a}}e.sort(function(t,e){return e-t});var u=window.screen.availWidth/e[0],c=document.createElement(\"meta\");c.setAttribute(\"name\",\"viewport\"),c.setAttribute(\"content\",\"width=device-width,minimum-scale=\"+u+\",maximum-scale=\"+u+\",user-scalable=no\"),document.body.appendChild(c)}}();</script>
        """
    }
}
