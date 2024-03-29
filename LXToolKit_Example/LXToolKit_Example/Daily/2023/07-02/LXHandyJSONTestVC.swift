//
//  LXHandyJSONTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/7/2.
//
import UIKit
import ObjectMapper
import Moya_ObjectMapper
import RxSwift
import SVProgressHUD

// MARK: - 🔐
private extension LXHandyJSONTestVC {
    private static let testFloatList: [Double] = [
        0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,
        1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9,
        2, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9,
        3, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9,
        4, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9,
        5, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9,
        6, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9,
        7, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9,
        8, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9,
        9, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 9.7, 9.8, 9.9,
        10, 10.1, 10.2, 10.3, 10.4, 10.5, 10.6, 10.7, 10.8, 10.9,
        11, 11.1, 11.2, 11.3, 11.4, 11.5, 11.6, 11.7, 11.8, 11.9,
        12, 12.1, 12.2, 12.3, 12.4, 12.5, 12.6, 12.7, 12.8, 12.9,
        13, 13.1, 13.2, 13.3, 13.4, 13.5, 13.6, 13.7, 13.8, 13.9,
        14, 14.1, 14.2, 14.3, 14.4, 14.5, 14.6, 14.7, 14.8, 14.9,
        15, 15.1, 15.2, 15.3, 15.4, 15.5, 15.6, 15.7, 15.8, 15.9,
        16, 16.1, 16.2, 16.3, 16.4, 16.5, 16.6, 16.7, 16.8, 16.9,
        17, 17.1, 17.2, 17.3, 17.4, 17.5, 17.6, 17.7, 17.8, 17.9,
        18, 18.1, 18.2, 18.3, 18.4, 18.5, 18.6, 18.7, 18.8, 18.9,
        19, 19.1, 19.2, 19.3, 19.4, 19.5, 19.6, 19.7, 19.8, 19.9,
        20, 20.1, 20.2, 20.3, 20.4, 20.5, 20.6, 20.7, 20.8, 20.9,
        21, 21.1, 21.2, 21.3, 21.4, 21.5, 21.6, 21.7, 21.8, 21.9,
        22, 22.1, 22.2, 22.3, 22.4, 22.5, 22.6, 22.7, 22.8, 22.9,
        23, 23.1, 23.2, 23.3, 23.4, 23.5, 23.6, 23.7, 23.8, 23.9,
        24, 24.1, 24.2, 24.3, 24.4, 24.5, 24.6, 24.7, 24.8, 24.9,
        25, 25.1, 25.2, 25.3, 25.4, 25.5, 25.6, 25.7, 25.8, 25.9,
        26, 26.1, 26.2, 26.3, 26.4, 26.5, 26.6, 26.7, 26.8, 26.9,
        27, 27.1, 27.2, 27.3, 27.4, 27.5, 27.6, 27.7, 27.8, 27.9,
        28, 28.1, 28.2, 28.3, 28.4, 28.5, 28.6, 28.7, 28.8, 28.9,
        29, 29.1, 29.2, 29.3, 29.4, 29.5, 29.6, 29.7, 29.8, 29.9,
        30, 30.1, 30.2, 30.3, 30.4, 30.5, 30.6, 30.7, 30.8, 30.9,
        31, 31.1, 31.2, 31.3, 31.4, 31.5, 31.6, 31.7, 31.8, 31.9,
        32, 32.1, 32.2, 32.3, 32.4, 32.5, 32.6, 32.7, 32.8, 32.9,
        33, 33.1, 33.2, 33.3, 33.4, 33.5, 33.6, 33.7, 33.8, 33.9,
        34, 34.1, 34.2, 34.3, 34.4, 34.5, 34.6, 34.7, 34.8, 34.9,
        35, 35.1, 35.2, 35.3, 35.4, 35.5, 35.6, 35.7, 35.8, 35.9,
        36, 36.1, 36.2, 36.3, 36.4, 36.5, 36.6, 36.7, 36.8, 36.9,
        37, 37.1, 37.2, 37.3, 37.4, 37.5, 37.6, 37.7, 37.8, 37.9,
        38, 38.1, 38.2, 38.3, 38.4, 38.5, 38.6, 38.7, 38.8, 38.9,
        39, 39.1, 39.2, 39.3, 39.4, 39.5, 39.6, 39.7, 39.8, 39.9,
        40, 40.1, 40.2, 40.3, 40.4, 40.5, 40.6, 40.7, 40.8, 40.9,
        41, 41.1, 41.2, 41.3, 41.4, 41.5, 41.6, 41.7, 41.8, 41.9,
        42, 42.1, 42.2, 42.3, 42.4, 42.5, 42.6, 42.7, 42.8, 42.9,
        43, 43.1, 43.2, 43.3, 43.4, 43.5, 43.6, 43.7, 43.8, 43.9,
        44, 44.1, 44.2, 44.3, 44.4, 44.5, 44.6, 44.7, 44.8, 44.9,
        45, 45.1, 45.2, 45.3, 45.4, 45.5, 45.6, 45.7, 45.8, 45.9,
        46, 46.1, 46.2, 46.3, 46.4, 46.5, 46.6, 46.7, 46.8, 46.9,
        47, 47.1, 47.2, 47.3, 47.4, 47.5, 47.6, 47.7, 47.8, 47.9,
        48, 48.1, 48.2, 48.3, 48.4, 48.5, 48.6, 48.7, 48.8, 48.9,
        49, 49.1, 49.2, 49.3, 49.4, 49.5, 49.6, 49.7, 49.8, 49.9,
        50, 50.1, 50.2, 50.3, 50.4, 50.5, 50.6, 50.7, 50.8, 50.9,
        51, 51.1, 51.2, 51.3, 51.4, 51.5, 51.6, 51.7, 51.8, 51.9,
        52, 52.1, 52.2, 52.3, 52.4, 52.5, 52.6, 52.7, 52.8, 52.9,
        53, 53.1, 53.2, 53.3, 53.4, 53.5, 53.6, 53.7, 53.8, 53.9,
        54, 54.1, 54.2, 54.3, 54.4, 54.5, 54.6, 54.7, 54.8, 54.9,
        55, 55.1, 55.2, 55.3, 55.4, 55.5, 55.6, 55.7, 55.8, 55.9,
        56, 56.1, 56.2, 56.3, 56.4, 56.5, 56.6, 56.7, 56.8, 56.9,
        57, 57.1, 57.2, 57.3, 57.4, 57.5, 57.6, 57.7, 57.8, 57.9,
        58, 58.1, 58.2, 58.3, 58.4, 58.5, 58.6, 58.7, 58.8, 58.9,
        59, 59.1, 59.2, 59.3, 59.4, 59.5, 59.6, 59.7, 59.8, 59.9,
        60, 60.1, 60.2, 60.3, 60.4, 60.5, 60.6, 60.7, 60.8, 60.9,
        61, 61.1, 61.2, 61.3, 61.4, 61.5, 61.6, 61.7, 61.8, 61.9,
        62, 62.1, 62.2, 62.3, 62.4, 62.5, 62.6, 62.7, 62.8, 62.9,
        63, 63.1, 63.2, 63.3, 63.4, 63.5, 63.6, 63.7, 63.8, 63.9,
        64, 64.1, 64.2, 64.3, 64.4, 64.5, 64.6, 64.7, 64.8, 64.9,
        65, 65.1, 65.2, 65.3, 65.4, 65.5, 65.6, 65.7, 65.8, 65.9,
        66, 66.1, 66.2, 66.3, 66.4, 66.5, 66.6, 66.7, 66.8, 66.9,
        67, 67.1, 67.2, 67.3, 67.4, 67.5, 67.6, 67.7, 67.8, 67.9,
        68, 68.1, 68.2, 68.3, 68.4, 68.5, 68.6, 68.7, 68.8, 68.9,
        69, 69.1, 69.2, 69.3, 69.4, 69.5, 69.6, 69.7, 69.8, 69.9,
        70, 70.1, 70.2, 70.3, 70.4, 70.5, 70.6, 70.7, 70.8, 70.9,
        71, 71.1, 71.2, 71.3, 71.4, 71.5, 71.6, 71.7, 71.8, 71.9,
        72, 72.1, 72.2, 72.3, 72.4, 72.5, 72.6, 72.7, 72.8, 72.9,
        73, 73.1, 73.2, 73.3, 73.4, 73.5, 73.6, 73.7, 73.8, 73.9,
        74, 74.1, 74.2, 74.3, 74.4, 74.5, 74.6, 74.7, 74.8, 74.9,
        75, 75.1, 75.2, 75.3, 75.4, 75.5, 75.6, 75.7, 75.8, 75.9,
        76, 76.1, 76.2, 76.3, 76.4, 76.5, 76.6, 76.7, 76.8, 76.9,
        77, 77.1, 77.2, 77.3, 77.4, 77.5, 77.6, 77.7, 77.8, 77.9,
        78, 78.1, 78.2, 78.3, 78.4, 78.5, 78.6, 78.7, 78.8, 78.9,
        79, 79.1, 79.2, 79.3, 79.4, 79.5, 79.6, 79.7, 79.8, 79.9,
        80, 80.1, 80.2, 80.3, 80.4, 80.5, 80.6, 80.7, 80.8, 80.9,
        81, 81.1, 81.2, 81.3, 81.4, 81.5, 81.6, 81.7, 81.8, 81.9,
        82, 82.1, 82.2, 82.3, 82.4, 82.5, 82.6, 82.7, 82.8, 82.9,
        83, 83.1, 83.2, 83.3, 83.4, 83.5, 83.6, 83.7, 83.8, 83.9,
        84, 84.1, 84.2, 84.3, 84.4, 84.5, 84.6, 84.7, 84.8, 84.9,
        85, 85.1, 85.2, 85.3, 85.4, 85.5, 85.6, 85.7, 85.8, 85.9,
        86, 86.1, 86.2, 86.3, 86.4, 86.5, 86.6, 86.7, 86.8, 86.9,
        87, 87.1, 87.2, 87.3, 87.4, 87.5, 87.6, 87.7, 87.8, 87.9,
        88, 88.1, 88.2, 88.3, 88.4, 88.5, 88.6, 88.7, 88.8, 88.9,
        89, 89.1, 89.2, 89.3, 89.4, 89.5, 89.6, 89.7, 89.8, 89.9,
        90, 90.1, 90.2, 90.3, 90.4, 90.5, 90.6, 90.7, 90.8, 90.9,
        91, 91.1, 91.2, 91.3, 91.4, 91.5, 91.6, 91.7, 91.8, 91.9,
        92, 92.1, 92.2, 92.3, 92.4, 92.5, 92.6, 92.7, 92.8, 92.9,
        93, 93.1, 93.2, 93.3, 93.4, 93.5, 93.6, 93.7, 93.8, 93.9,
        94, 94.1, 94.2, 94.3, 94.4, 94.5, 94.6, 94.7, 94.8, 94.9,
        95, 95.1, 95.2, 95.3, 95.4, 95.5, 95.6, 95.7, 95.8, 95.9,
        96, 96.1, 96.2, 96.3, 96.4, 96.5, 96.6, 96.7, 96.8, 96.9,
        97, 97.1, 97.2, 97.3, 97.4, 97.5, 97.6, 97.7, 97.8, 97.9,
        98, 98.1, 98.2, 98.3, 98.4, 98.5, 98.6, 98.7, 98.8, 98.9,
        99, 99.1, 99.2, 99.3, 99.4, 99.5, 99.6, 99.7, 99.8, 99.9,
        100, 100.1, 100.2, 100.3, 100.4, 100.6, 100.5, 100.7, 100.8, 100.9,
        101, 101.1, 101.2, 101.3, 101.4, 101.6, 101.5, 101.7, 101.8, 101.9,
        102, 102.1, 102.2, 102.3, 102.4, 102.6, 102.5, 102.7, 102.8, 102.9,
        103, 103.1, 103.2, 103.3, 103.4, 103.6, 103.5, 103.7, 103.8, 103.9,
        104, 104.1, 104.2, 104.3, 104.4, 104.6, 104.5, 104.7, 104.8, 104.9,
        105, 105.1, 105.2, 105.3, 105.4, 105.6, 105.5, 105.7, 105.8, 105.9,
        106, 106.1, 106.2, 106.3, 106.4, 106.6, 106.5, 106.7, 106.8, 106.9,
        107, 107.1, 107.2, 107.3, 107.4, 107.6, 107.5, 107.7, 107.8, 107.9,
        108, 108.1, 108.2, 108.3, 108.4, 108.6, 108.5, 108.7, 108.8, 108.9,
        109, 109.1, 109.2, 109.3, 109.4, 109.6, 109.5, 109.7, 109.8, 109.9,
        ]
}

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
    private lazy var btnHeaderRefresh: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)

        btn.setTitle("Header Refresh", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.magenta.cgColor
        return btn
    }()
    private lazy var btnFootererRefresh: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)

        btn.setTitle("Footer Refresh", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.magenta.cgColor
        return btn
    }()
    // MARK: 🔗Vaiables
    let headerTrigger = PublishSubject<Void>()
    let footerTrigger = PublishSubject<Void>()
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareVM()
        bindViewModel()
        testFloat()
    }
}

// MARK: 🌎LoadData
extension LXHandyJSONTestVC {
    override func bindViewModel() {
        super.bindViewModel()
        guard let vm = vm as? LXFloatTestVM else { return }
        let headerTrigger = Observable
            .of(headerTrigger)
            .merge()
        let footerTrigger = Observable
            .of(footerTrigger)
            .merge()
        let intput = LXFloatTestVM.Input(headerRefresh: headerTrigger, footerRefresh: footerTrigger)
        let output = vm.transform(input: intput)
        output.floatModel
            .subscribe(onNext: { model in
                let sum = model.all.reduce(0, +)
                dlog("-->floatModel: \(model)")
                dlog("-->sum[float]: \(sum)")
            })
            .disposed(by: rx.disposeBag)
        output.codableModel
            .subscribe(onNext: { model in
                let sum = model.all.reduce(0, +)
                dlog("-->codableModel: \(model)")
                dlog("-->sum[codable]: \(sum)")
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension LXHandyJSONTestVC {}

// MARK: 🔐Private Actions
private extension LXHandyJSONTestVC {
    func testOpionArg() {
        optionArg(t1: 1, t2: 2)
        optionArg(t1: 1, t2: 2, t3: 3)
        optionArg(t1: 1, t2: 2, t4: 4)
        optionArg(t1: 1, t2: 2, t5: 5)
        optionArg(t1: 1, t2: 2, t3: 3, t4: 4)
        optionArg(t1: 1, t2: 2, t3: 3, t5: 5)
        optionArg(t1: 1, t2: 2, t4: 3, t5: 4)
        optionArg(t1: 1, t2: 2, t3: 3, t4: 4, t5: 5)
    }
    func optionArg(t1: Int, t2: Int, t3: Int = 1, t4: Int = 1, t5: Int = 1) {
    }
    func testFloat() {
        let testNumberList = stride(from: 0, to: 100, by: 0.1).compactMap { $0 }
        let json: [String: Any] = [
            "f0": stride(from: 0, to: 10, by: 0.1).compactMap { $0 },
            "f1": stride(from: 10, to: 20, by: 0.1).compactMap { $0 },
            "f2": stride(from: 20, to: 30, by: 0.1).compactMap { $0 },
            "f3": stride(from: 30, to: 40, by: 0.1).compactMap { $0 },
            "f4": stride(from: 40, to: 50, by: 0.1).compactMap { $0 },
            "f5": stride(from: 50, to: 60, by: 0.1).compactMap { $0 },
            "f6": stride(from: 60, to: 70, by: 0.1).compactMap { $0 },
            "f7": stride(from: 70, to: 80, by: 0.1).compactMap { $0 },
            "f8": stride(from: 80, to: 90, by: 0.1).compactMap { $0 },
            "f9": stride(from: 90, to: 100, by: 0.1).compactMap { $0 },
            "f10": stride(from: 100, to: 110, by: 0.1).compactMap { $0 },
            "f11": testNumberList,
            "f12": LXHandyJSONTestVC.testFloatList,
            // "f12": [0.3, 99.4],
            "t1": 0.3,
            "t2": 99.4,
        ]
        let test1 = {
            let start = DispatchTime.now()
            let m3 = LXFloatTestModel(JSON: json)
            guard let m1 = m3 else {
                return
            }
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timestamp = Double(nanoTime) / 1_000_000_000
            dlog("-->timestamp1: \(timestamp)")
            let sum1 = m1.all.reduce(0, +)
            dlog("sum1: \(sum1)")
        }
        let test2 = {
            guard let data = json.jsonData() else {
                return
            }
            do {
                let start2 = DispatchTime.now()
                let decoder = JSONDecoder()
                let m2 = try decoder.decode(LXCodableTestModel.self, from: data)
                let end2 = DispatchTime.now()
                let nanoTime2 = end2.uptimeNanoseconds - start2.uptimeNanoseconds
                let timestamp2 = Double(nanoTime2) / 1_000_000_000
                dlog("-->timestamp2: \(timestamp2)")
                let sum2 = m2.all.reduce(0, +)
                dlog("sum2: \(sum2)")
            } catch {
                dlog("error: \(error)")
            }
        }
        test1()
        test2()
        // dlog("json: \(json)")
        let sum = testNumberList.reduce(0, +)
        dlog("-->sum: \(sum)")
    }
    func testRandom() {
        enum Foo: String, CaseIterable {
            case a, b, c
        }
        if let random = Foo.randomCaseIterableElement() {
            dlog("random: \(random)")
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXHandyJSONTestVC {
    func prepareVM() {
        btnHeaderRefresh.rx.controlEvent(.touchUpInside)
            // .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                self?.headerTrigger.onNext(())
                // self?.testRandom()
            }
            .disposed(by: rx.disposeBag)
        btnFootererRefresh.rx.controlEvent(.touchUpInside)
            // .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                self?.footerTrigger.onNext(())
            }
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {
        navigationItem.title = "float testing"
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        [titleTextview, btnHeaderRefresh, btnFootererRefresh].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        titleTextview.snp.makeConstraints {
            $0.top.equalTo(self.view.snp_topMargin)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.snp_bottomMargin)
        }
        btnHeaderRefresh.snp.makeConstraints {
            $0.center.equalToSuperview()
            // $0.centerX.equalToSuperview()
            // $0.height.equalTo(44)
        }
        btnFootererRefresh.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(btnHeaderRefresh.snp.right).offset(10)
            // $0.height.equalTo(btnHeaderRefresh)
        }
    }
}
