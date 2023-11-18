//
//  LXFloatTestVM.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/17.
//
import RxSwift
import RxCocoa

extension LXFloatTestVM: LXViewModelType {
    struct Input {
        let headerRefresh: Observable<Void>
        // let footerRefresh: Observable<Void>
    }
    struct Output {
        // let dataList: BehaviorRelay<<#[LXEventCellVM]#>>
        let floatModel: PublishRelay<LXFloatTestModel>
    }
    func transform(input: Input) -> Output {
        let floatModel = PublishRelay<LXFloatTestModel>()
        let provider = TestFloatNetworking.defaultNetworking()
        /// 1. 下拉刷新
        input.headerRefresh
            // .debug("-->headerRefresh:")
            .flatMapLatest { [weak self] _ in
                guard let `self` = self else {
                    // return Observable.just(nil)
                    let error = NSError(domain: "233", code: 999)
                    throw MoyaError.encodableMapping(error)
                }
                self.page = 1
                // return self.request()
                return provider.request(.testFloat(id: "123"))
                    // .debug("-->query:")
                    .mapObject(LXFloatTestModel.self)
                    .trackActivity(self.loading)
                    .trackError(self.error)
                    .materialize()
            }
            .subscribe(onNext: {[weak self] event in
                // guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    floatModel.accept(result)
                default: break
                }
            })
            .disposed(by: rx.disposeBag)

        /// 2. 上提加载
        // input.footerRefresh
        //     .flatMapLatest {[weak self] () -> Observable<<#[LXEventCellVM]#>> in
        //         guard let `self` = self else { return Observable.just([]) }
        //         self.page += 1
        //         return self.request()
        //             .trackActivity(self.footerLoading)
        //     }
        //     .subscribe(onNext: {[weak self] item in
        //         // guard let `self` = self else { return }
        //         dataList.accept(dataList.value + item)
        //     })
        //     .disposed(by: rx.disposeBag)
        return Output(
            // dataList: dataList
            floatModel: floatModel
        )
    }
}

class LXFloatTestVM: LXBaseVM {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    // override init(provider: DJAPI) {
    //     super.init(provider: provider as! DJAPI)
    // }
}

// MARK: 👀Public Actions
extension LXFloatTestVM {}

// MARK: 🔐Private Actions
private extension LXFloatTestVM {
    // func request() -> Observable<LXFloatTestModel> {
    //     var request: Single<[Event]>
    //     return request
    // }
}
