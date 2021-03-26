//
//  LXRx0225VC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/2/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import LXToolKit

class LXRx0225VC: UIViewController {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
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
//        createObservable()
//        subscribeObservable()
//        publishSubject()
//        behaviorSubject()
        replaySubject()
    }

}

// MARK: 🌎LoadData
extension LXRx0225VC {}

// MARK: 👀Public Actions
extension LXRx0225VC {}

// MARK: 🔐Private Actions
private extension LXRx0225VC {
    /// 创建 Observable 序列
    func createObservable() {
        /// 1. just
        let obJust = Observable.just(5)
        let obJust2 = Observable<Int>.just(5)

        /// 2. of
        let obOf1 = Observable.of("A")
        let obOf2 = Observable.of("A", "B", "C")

        /// 3. from
        let obFrom1 = Observable.from(["A", "B", "C"])

        /// 4. empty
        let obEmpty = Observable<Int>.empty()

        /// 5. never
        let obNever = Observable<Int>.never()

        /// 6. error
        enum MyError: Error {
            case A
            case B
            case C
        }
        let obError = Observable<Int>.error(MyError.A)

        /// 7. range
        let obRange = Observable.range(start: 1, count: 20)

        /// 8. repeatElement
        let obRepeatElement = Observable.repeatElement(1)

        /// 9. generate
        let obGenerate = Observable.generate(initialState: 0, condition: { $0 <= 10}, iterate: { $0 + 2 })

        /// 10. create
        let obCreate = Observable<String>.create { observer -> Disposable in
            observer.onNext("1")
            observer.onCompleted()
            return Disposables.create()
        }

        /// 11. deferred
        var isOdd = true
        let obDeferred = Observable<Int>.deferred({ () -> Observable<Int> in
            isOdd = !isOdd
            if isOdd {
                return Observable.of(1, 3, 5, 7)
            } else {
                return Observable.of(2, 4, 6, 8)
            }
        })
//        obDeferred.subscribe { e in
//            dlog("obDeferred: \(isOdd): \(e)")
//        }
//        obDeferred.subscribe { e in
//            dlog("obDeferred: \(isOdd): \(e)")
//        }

        /// 12. interval
        let obInterval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        obInterval.subscribe { e in
//            dlog("obInterval: \(e)")
//        }

        /// 13.1 timer: 5秒种后发出唯一的一个元素0
        let obTimer1 = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
//        obTimer1.subscribe { e in
//            dlog("obTimer1: \(e)")
//        }

        /// 13.2 timer: 延时5秒种后，每隔1秒钟发出一个元素
        let obTimer2 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        obTimer2.subscribe { e in
            dlog("obTimer2: \(e)")
        }
    }

    func subscribeObservable() {
        let obOf2 = Observable
            .of("A", "B", "C")
            .do(onNext: { ele in
                dlog("🛠3.2 do onNext: \(ele)")
            }, afterNext: { ele in
                dlog("🛠5. do afterNext: \(ele)")
            }, onError: { e in
                dlog("🛠6. do onError: \(e)")
            }, afterError: { e in
                dlog("🛠6. do afterError: \(e)")
            }, onCompleted: {
                dlog("🛠6. do onCompleted")
            }, afterCompleted: {
                dlog("🛠9. do afterCompleted")
            }, onSubscribe: {
                dlog("🛠1. do onSubscribe")
            }, onSubscribed: {
                dlog("🛠2. do onSubscribed")
            }, onDispose: {
                dlog("🛠10. do onDispose")
            })
        /// 1.
//        obOf2.subscribe { e in
//            dlog("obOf2: \(e.element)")
//        }

        /// 2.
        obOf2
            .subscribe { ele in
                dlog("4. obOf2: \(ele)")
            } onError: { e in
                dlog("Error: \(e)")
            } onCompleted: {
                dlog("7. onCompleted")
            } onDisposed: {
                dlog("8. onDisposed")
            }

    }

    func createObserver() {
        /// 1. 在 subscribe 方法中创建
        let f1 = ({
            let obOf = Observable.of("A", "B", "C")
            obOf.subscribe { ele in
                dlog("onNext: \(ele)")
            } onError: { error in
                dlog("onError: \(error)")
            } onCompleted: {
                dlog("onCompleted")
            } onDisposed: {
                dlog("onDisposed")
            }
        })
//        f1()

        /// 2. 在 bind 方法中创建
        let f2 = ({
            let obInterval = Observable<Int>
                .interval(1, scheduler: MainScheduler.instance)
                .map { "Idx: \($0)" }
                .bind { [weak self] text in
                    self?.labTitle.text = text
                }
                .disposed(by: self.rx.disposeBag)
        })
//        f2()

        /// 3. 使用 AnyObserver 创建观察者
        /// 3.1 配合 subscribe 方法使用
        let f31 = ({
            let observerAny = AnyObserver<String> { e in
                switch e {
                    case .next(let data):
                        dlog(".next: \(data)")
                    case .error(let error):
                        dlog(".error: \(error)")
                    case .completed:
                        dlog(".completed")
                }
            }
            Observable
                .of("A", "B", "C")
                .subscribe(observerAny)

        })
//        f31()

        /// 3.2 配合 bindTo 方法使用
        let f32 = ({
            let observerAny = AnyObserver<String> { [weak self]e in
                guard let `self` = self else { return }
                switch e {
                    case .next(let data):
                        self.labTitle.text = data
                    default: break
                }
            }
            Observable<Int>
                .interval(1, scheduler: MainScheduler.instance)
                .map { "idx: \($0)" }
                .bind(to: observerAny)
                .disposed(by: self.rx.disposeBag)
        })
//        f32()

        /// 4. 使用 Binder 创建观察者
        let f4 = ({
            let binder = Binder<String>(self.labTitle) { (view, data) in
                view.text = data
            }

            Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                .map { "idx: \($0)" }
                .bind(to: binder)
                .disposed(by: self.rx.disposeBag)
        })
//        f4()

        /// 5. RxSwift 自带的可绑定属性（UI 观察者）
        let f5 = ({
            Observable<Int>
                .interval(1, scheduler: MainScheduler.instance)
                .map { "idx: \($0)" }
                .bind(to: self.labTitle.rx.text)
        })
        f5()
    }

    func publishSubject() {
        let pSubject = PublishSubject<String>()
        pSubject.onNext("1")
        pSubject.subscribe { ele in
            dlog("a.onNext: \(ele)")
        } onError: { error in
            dlog("a.onError: \(error)")
        } onCompleted: {
            dlog("a.onCompleted")
        } onDisposed: {
            dlog("a.onDisposed")
        }
        pSubject.onNext("2")
        pSubject.onCompleted()
        pSubject.onNext("3")
        pSubject.subscribe { ele in
            dlog("b.onNext: \(ele)")
        } onError: { error in
            dlog("b.onError: \(error)")
        } onCompleted: {
            dlog("b.onCompleted")
        } onDisposed: {
            dlog("b.onDisposed")
        }
        pSubject.onNext("4")
    }

    func behaviorSubject() {
        let bSubject = BehaviorSubject<String>(value: "0")
        bSubject.subscribe { ele in
            dlog("a.onNext: \(ele)")
        } onError: { error in
            dlog("a.onError: \(error)")
        } onCompleted: {
            dlog("a.onCompleted")
        } onDisposed: {
            dlog("a.onDisposed")
        }
        bSubject.onNext("2")
        bSubject.onNext("3")
        bSubject.subscribe { ele in
            dlog("b.onNext: \(ele)")
        } onError: { error in
            dlog("b.onError: \(error)")
        } onCompleted: {
            dlog("b.onCompleted")
        } onDisposed: {
            dlog("b.onDisposed")
        }
        bSubject.onCompleted()
        bSubject.subscribe { ele in
            dlog("c.onNext: \(ele)")
        } onError: { error in
            dlog("c.onError: \(error)")
        } onCompleted: {
            dlog("c.onCompleted")
        } onDisposed: {
            dlog("c.onDisposed")
        }
        bSubject.onNext("4")
    }

    func replaySubject() {
        let rSubject = ReplaySubject<String>.create(bufferSize: 2)
        let a = rSubject.xl_subscribeTest("a")

        rSubject.onNext("1")
        rSubject.onNext("2")
        rSubject.onNext("3")
        rSubject.xl_subscribeTest("b")
        rSubject.onCompleted()
        rSubject.xl_subscribeTest("c")
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXRx0225VC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        [labTitle].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
        labTitle.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.centerX.equalToSuperview()
        }
    }
}

class LXAnyModel233: NSObject, HandyJSON {
    deinit {
        dlog("---------- >>>Model: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    required public override init() {}
    open override var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "NaN"
    }

    /// override var debugDescription: String { return "" }
}
