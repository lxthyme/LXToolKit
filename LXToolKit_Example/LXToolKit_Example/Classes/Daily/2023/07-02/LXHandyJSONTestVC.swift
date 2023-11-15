//
//  LXHandyJSONTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/7/2.
//
import UIKit
import ObjectMapper

class LXHandyJSONTestVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var titleTextview: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = .black
        tv.backgroundColor = .white
        tv.isEditable = false
        tv.textAlignment = .left
        return tv
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
        
        testFloat()
    }
}

// MARK: 🌎LoadData
extension LXHandyJSONTestVC {}

// MARK: 👀Public Actions
extension LXHandyJSONTestVC {}

// MARK: 🔐Private Actions
private extension LXHandyJSONTestVC {
    func testOpionArg() {
        optionArg(t1: 1, t2: 2)
        optionArg(t1: 1, t2: 2, t3: 3)
        optionArg(t1: 1, t2: 2, t4: 3)
        optionArg(t1: 1, t2: 2, t5: 3)
        optionArg(t1: 1, t2: 2, t3: 3, t4: 4)
        optionArg(t1: 1, t2: 2, t3: 3, t5: 4)
        optionArg(t1: 1, t2: 2, t4: 3, t5: 4)
    }
    func optionArg(t1: Int, t2: Int, t3: Int = 1, t4: Int = 1, t5: Int = 1) {
    }
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
         .91, .90, .93, .92, .95, .94, .97, .96, .99, .98,
         .100, .101, .102, .103, .104, .105, .106, .107, .108, .109
         */
        // let testNumberList = stride(from: 0, to: 100, by: 0.1).compactMap { $0 }
        let testNumberList = [0.3, 0.6, 0.7, 99.7, 99.8, 99.6]
        let json: [String: Any] = [
            "f0": stride(from: 0, to: 10, by: 0.1).compactMap { $0 },
            "f1": stride(from: 10, to: 20, by: 0.1).compactMap { $0 },
            "f2": stride(from: 10, to: 30, by: 0.1).compactMap { $0 },
            "f3": stride(from: 10, to: 40, by: 0.1).compactMap { $0 },
            "f4": stride(from: 40, to: 50, by: 0.1).compactMap { $0 },
            "f5": stride(from: 50, to: 60, by: 0.1).compactMap { $0 },
            "f6": stride(from: 60, to: 70, by: 0.1).compactMap { $0 },
            "f7": stride(from: 70, to: 80, by: 0.1).compactMap { $0 },
            "f8": stride(from: 80, to: 90, by: 0.1).compactMap { $0 },
            "f9": stride(from: 90, to: 100, by: 0.1).compactMap { $0 },
            "f10": stride(from: 100, to: 110, by: 0.1).compactMap { $0 },
            "f11": [99.1, 99.4, 99.6, 99.9],
            "t1": 26.9,
            "t2": 27.4,
        ]
        let start = DispatchTime.now()
        guard let m1 = LXFloatTestModel(JSON: json) else {
            return
        }
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timestamp = Double(nanoTime) / 1_000_000_000
        dlog("-->timestamp: \(timestamp)")
        // dlog("json: \(json)")
        let sum = testNumberList.reduce(0, +)
        dlog("-->sum: \(sum)")
        guard let data = json.jsonData() else {
            return
        }
        do {
        let start2 = DispatchTime.now()
        let decoder = JSONDecoder()
        let m2 = try decoder.decode(LXCodableTestModel.self, from: data)
        let end2 = DispatchTime.now()
        let nanoTime2 = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timestamp2 = Double(nanoTime) / 1_000_000_000
        dlog("-->timestamp2: \(timestamp2)")
        dlog("m2: \(m2)")
            /// m1.f0?.compactMap { $0.string }.filter { $0.count > 5 }
        // dlog("model: \(model.debugDescription)")
        // dlog("model: \(model.toJSONString(prettyPrint: true) ?? "")")
        // dlog("sum: \(sum ?? 0)")
        // titleTextview.text = model.debugDescription
        } catch {
            dlog("error: \(error)")
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
extension LXHandyJSONTestVC {
    override func prepareUI() {
        super.prepareUI()
        navigationItem.title = "float testing"
        self.view.backgroundColor = .white
        // self.title = "<#title#>"
        
        [titleTextview].forEach(self.view.addSubview)
        
        masonry()
    }
    
    override func masonry() {
        super.masonry()
        titleTextview.snp.makeConstraints {
            $0.top.equalTo(self.view.snp_topMargin)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.snp_bottomMargin)
        }
    }
}
