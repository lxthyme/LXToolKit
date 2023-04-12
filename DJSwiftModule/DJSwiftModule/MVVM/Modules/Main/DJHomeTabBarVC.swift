//
//  DJHomeTabBarVC.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import UIKit
import RAMAnimatedTabBarController
import RxSwift

enum DJHomeTabBarItem: Int {
    case search, news, notifications, settings, login

    var image: UIImage? {
        switch self {
        case .search:
            return R.image.icon_tabbar_search()
        case .news:
            return R.image.icon_tabbar_news()
        case .notifications:
            return R.image.icon_tabbar_activity()
        case .settings:
            return R.image.icon_tabbar_settings()
        case .login:
            return R.image.icon_tabbar_login()
        }
    }
    var title: String {
        switch self {
        case .search: return R.string.localizable.homeTabBarSearchTitle()
        case .news: return R.string.localizable.homeTabBarEventsTitle()
        case .notifications: return R.string.localizable.homeTabBarNotificationsTitle()
        case .settings: return R.string.localizable.homeTabBarSettingsTitle()
        case .login: return R.string.localizable.homeTabBarLoginTitle()
        }
    }
    var animation: RAMItemAnimation {
        var animation: RAMItemAnimation
        switch self {
        case .search:
                animation = RAMFlipLeftTransitionItemAnimations()
        case .news:
            animation = RAMBounceAnimation()
        case .notifications:
            animation = RAMBounceAnimation()
        case .settings:
            animation = RAMRightRotationAnimation()
        case .login:
            animation = RAMBounceAnimation()
        }
        animation.theme.iconSelectedColor = themeService.attribute { $0.secondary }
        animation.theme.textSelectedColor = themeService.attribute { $0.secondary }
        return animation
    }
    
    private func controller(with vm: LXBaseVM, navigator: Navigator) -> UIViewController {
        switch self {
        case .search:
            let vc = DJSearchVC(vm: vm, navigator: navigator)
            return UINavigationController(rootViewController: vc)
        case .news:
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            return UINavigationController(rootViewController: vc)
        case .notifications:
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            return UINavigationController(rootViewController: vc)
        case .settings:
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            return UINavigationController(rootViewController: vc)
        case .login:
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            return UINavigationController(rootViewController: vc)
        }
    }

    func getVC(with vm: LXBaseVM, navigator: Navigator) -> UIViewController {
        let vc = controller(with: vm, navigator: navigator)
        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
        item.animation = animation
        item.theme.iconColor = themeService.attribute { $0.text }
        item.theme.textColor = themeService.attribute { $0.text }
        vc.tabBarItem = item
        return vc
    }
}

class DJHomeTabBarVC: RAMAnimatedTabBarController, Navigatable {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var vm: DJHomeTabBarVM?
    var navigator: Navigator
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(vm: DJHomeTabBarVM?, navigator: Navigator) {
        self.vm = vm
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareUI()
        bindVM()
    }
}

// MARK: 🌎LoadData
extension DJHomeTabBarVC {
    func bindVM() {
        guard let vm = self.vm else { return }

        let input = DJHomeTabBarVM.Input(whatsNewTrigger: rx.viewDidAppear.mapToVoid())
        let output = vm.transform(input: input)

        output.tabbarItems.delay(.milliseconds(50))
            .drive(onNext: { [weak self] itemList in
                guard let `self` = self else { return }
                let vcList = itemList.map { $0.getVC(with: vm.vm(for: $0), navigator: self.navigator) }
                self.setViewControllers(vcList, animated: false)
            })
            .disposed(by: rx.disposeBag)
        output.openWhatsNew
            .drive(onNext: { [weak self] block in
                if AppConfig.Network.useStaging == false {
                    // self?.navigator.show(segue: <#T##Navigator.Scene#>, sender: <#T##UIViewController?#>)
                }
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension DJHomeTabBarVC {}

// MARK: 🔐Private Actions
private extension DJHomeTabBarVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension DJHomeTabBarVC {
    func prepareNotification() {
        NotificationCenter.default.rx
            .notification(Notification.Name(LCLLanguageChangeNotification))
            .subscribe(onNext: {[weak self] notification in
                self?.animatedItems.forEach({ item in
                    item.title = DJHomeTabBarItem(rawValue: item.tag)?.title
                })
                self?.setViewControllers(self?.viewControllers, animated: false)
                self?.setSelectIndex(from: 0, to: self?.selectedIndex ?? 0)
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareVM() {
        themeService.typeStream
            .delay(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: { themeType in
                switch themeType {
                case .light(let color), .dark(let color):
                    self.changeSelectedColor(color.color, iconSelectedColor: color.color)
                }
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        tabBar.theme.barTintColor = themeService.attribute { $0.primaryDark }
        // [<#table#>].forEach(self.<#view#>.addSubview)
        masonry()
    }
    func masonry() {}
}

