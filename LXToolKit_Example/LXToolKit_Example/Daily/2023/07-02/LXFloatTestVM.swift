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
        let footerRefresh: Observable<Void>
    }
    struct Output {
        // let dataList: BehaviorRelay<<#[LXEventCellVM]#>>
        let floatModel: PublishRelay<LXFloatTestModel>
        let codableModel: PublishRelay<LXCodableTestModel>
    }
    func transform(input: Input) -> Output {
        let floatModel = PublishRelay<LXFloatTestModel>()
        let codableModel = PublishRelay<LXCodableTestModel>()
        let provider = FloatApi.provider
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
                return provider.testFloat(id: "123")
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
        input.footerRefresh
            .flatMapLatest {[weak self] _ in
                guard let `self` = self else {
                    let error = NSError(domain: "233", code: 999)
                    throw MoyaError.encodableMapping(error)
                }
                self.page += 1
                return provider.testFloatCodable(id: "123")
                .trackActivity(self.loading)
                .trackError(self.error)
                .do(onError: { error in
                    dlog("--> testFloat error: \(error)")
                })
                .materialize()
            }
            .subscribe(onNext: {[weak self] event in
                // guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    codableModel.accept(result)
                default: break
                }
            })
            .disposed(by: rx.disposeBag)
        return Output(
            // dataList: dataList
            floatModel: floatModel,
            codableModel: codableModel
        )
    }
}

class LXFloatTestVM: LXBaseVM {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
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
