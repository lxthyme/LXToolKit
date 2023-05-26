//
//  Application.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation

final class Application: NSObject {
    static let shared = Application()

    var window: UIWindow?
    var provider: DJAllAPI?
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
        let githubProvider: GithubNetworking = staging ? .stubbingNetworking() : .defaultNetworking()
        let trendingGithubProvider: TrendingGithubNetworking = staging ? .stubbingNetworking() : .defaultNetworking()
        let codetabsProvider: CodetabsNetworking = staging ? .stubbingNetworking() : .defaultNetworking()
        let restApi = RestApi(githubProvider: githubProvider,
                              trendingGithubProvider: trendingGithubProvider,
                              codetabsProvider: codetabsProvider)
        provider = restApi

        if let token = authManager.token,
           !AppConfig.Network.useStaging {
            switch token.type() {
            case .oAuth(let token), .personal(let token):
                provider = GraphApi(restApi: restApi, token: token)
            default: break
            }
        }
    }
}

// MARK: - 👀
extension Application {
    func presentInitialScreen(in window: UIWindow?) {
        updateProvider()
        guard let window, let provider else { return }

        self.window = window

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            // if let user = UserModel.currentUser(),
            //    let login = user.login {
            // }
            // let authorized = self.authManager.token?.isValid ?? false
            // let vm = DJHomeTabBarVM(authorized: authorized, provider: provider)
            // self.navigator.show(segue: .tabs(vm: vm), sender: nil, transition: .root(in: window))
        }
    }

    func presentTestScreen(in window: UIWindow) {
        // guard let window, let provider else { return }
        // let vm =
        // navigator.show(segue: <#T##Navigator.Scene#>, sender: <#T##UIViewController?#>)
    }
}
