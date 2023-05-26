//
//  HomeTabBarVM.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import WhatsNewKit
import LXToolKit

class DJHomeTabBarVM: LXBaseVM, LXViewModelType {
    struct Input {
        let whatsNewTrigger: Observable<Void>
    }
    struct Output {
        let tabbarItems: Driver<[DJHomeTabBarItem]>
        let openWhatsNew: Driver<WhatsNewBlock>
    }

    let authorized: Bool
    let whatsNewManager: WhatsNewManager

    init(authorized: Bool, provider: DJAllAPI) {
        self.authorized = authorized
        self.whatsNewManager = WhatsNewManager.shared
        super.init(provider: provider as! LXToolKit.DJAPI)
    }
    func transform(input: Input) -> Output {
        let tabbarItems = Observable
            .just(authorized)
            .map { authorized -> [DJHomeTabBarItem] in
                if authorized {
                    return [.news, .search, .notifications, .settings]
                } else {
                    return [.search, .login, .settings]
                }
            }
            .asDriver(onErrorJustReturn: [])
        let whatsNew = whatsNewManager.whatsNew()
        let whateNewItems = input
            .whatsNewTrigger
            .take(1)
            .map { whatsNew }
        return Output(tabbarItems: tabbarItems,
                      openWhatsNew: whateNewItems.asDriverOnErrorJustComplete())
    }
}

extension DJHomeTabBarVM {
    func vm(for tabbarItem: DJHomeTabBarItem) -> LXBaseVM {
        switch tabbarItem {
        case .search:
            let vm = DJSearchVM(provider: provider)
            return vm
        case .news:
            let vm = LXBaseVM(provider: provider)
            return vm
        case .notifications:
            let vm = LXBaseVM(provider: provider)
            return vm
        case .settings:
            let vm = LXBaseVM(provider: provider)
            return vm
        case .login:
            let vm = LXBaseVM(provider: provider)
            return vm
        }
    }
}
