//
//  Application.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import LXToolKit

final public class Application: NSObject {
    public static let shared = Application()

    var window: UIWindow?
    @objc public  var previousRootVC: UIViewController?
    var provider: RestApi?
    let authManager: AuthManager
    let navigator: Navigator

    private override init() {
        authManager = AuthManager.shared
        navigator = Navigator.default
        super.init()
        updateProvider()
    }

    private func updateProvider() {
        let staging = AppConfig.Network.useStaging
        let githubProvider = staging
        ? LXNetworking<GithubAPI>.stubbingNetworking()
        :  LXNetworking<GithubAPI>.defaultNetworking()
        let trendingGithubProvider = staging
        ? LXNetworking<TrendingGithubAPI>.stubbingNetworking()
        : LXNetworking<TrendingGithubAPI>.defaultNetworking()
        let codetabsProvider = staging
        ? LXNetworking<CodetabsApi>.stubbingNetworking()
        : LXNetworking<CodetabsApi>.defaultNetworking()
        let restApi = RestApi(githubProvider: githubProvider,
                              trendingGithubProvider: trendingGithubProvider,
                              codetabsProvider: codetabsProvider)
        provider = restApi

        // if let token = authManager.token,
        //    !AppConfig.Network.useStaging {
        //     switch token.type() {
        //     case .oAuth(let token), .personal(let token):
        //         provider = GraphApi(restApi: restApi, token: token)
        //     default: break
        //     }
        // }
    }
}

// MARK: - 👀
extension Application {
    @objc public  func presentInitialScreen(in window: UIWindow?) {
        updateProvider()
        guard let window, let provider else { return }

        self.window = window
        self.previousRootVC = window.rootViewController

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            // if let user = UserModel.currentUser(),
            //    let login = user.login {
            // }
            let authorized = self.authManager.token?.isValid ?? false
            let vm = DJHomeTabBarVM(authorized: authorized)
            self.navigator.show(segue: .tabs(vm: vm), sender: nil, transition: .root(in: window))
        }
    }
    public func dismissPreviousVC() {
        guard let window = self.window else { return }
        // self.dismiss(animated: true)
        self.navigator.show(segue: .vc(vcProvider: {[weak self] in
            return self?.previousRootVC
        }, transition: .root(in: window)),
                            sender: nil)
    }

    func presentTestScreen(in window: UIWindow) {
        // guard let window, let provider else { return }
        // let vm =
        // navigator.show(segue: <#T##Navigator.Scene#>, sender: <#T##UIViewController?#>)
    }
}
