//
//  LXLoginVM.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/3/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import RxSwift
import RxCocoa
import SafariServices
import AuthenticationServices
import CloudKit

private let loginURL = URL(string: "http://github.com/login/oauth/authorize?client_id=\(Keys.github.appId)&scope=\(Configs.App.githubScope)")!
private let callbackURLScheme = "swifthub"

extension LXLoginVM: LXViewModelType {
    struct Input {
        let segmentSelection: Driver<LoginSegments>
        let basicLoginTrigger: Driver<Void>
        let personalLoginTrigger: Driver<Void>
        let oAuthLoginTrigger: Driver<Void>
    }
    struct Output {
        let basicLoginBtnEnabled: Driver<Bool>
        let personalLoginBtnEnabled: Driver<Bool>
        let hidesBasicLoginView: Driver<Bool>
        let hidesPersonalLoginView: Driver<Bool>
        let hidesOAuthLoginView: Driver<Bool>
    }
    func transform(input: Input) -> Output {
        input.basicLoginTrigger
            .drive(onNext: {[weak self] () in
                if let login = self?.login.value,
                   let pwd = self?.pwd.value,
                   let authHash = "\(login):\(pwd)".base64Encoded {
                    AuthManager.setToken(token: Token(basicToken: authHash))
                    self?.tokenSaved.onNext(())
                }
            })
            .disposed(by: rx.disposeBag)
        input.personalLoginTrigger
            .drive(onNext: {[weak self] () in
                if let token = self?.personalToken.value {
                    AuthManager.setToken(token: Token(personalToken: token))
                    self?.tokenSaved.onNext(())
                }
            })
            .disposed(by: rx.disposeBag)
        input.oAuthLoginTrigger
            .drive(onNext: {[weak self] () in
                guard let `self` = self else { return }
                self.authSession = ASWebAuthenticationSession(url: loginURL, callbackURLScheme: callbackURLScheme, completionHandler: { url, error in
                    if let error = error {
                        logError(error.localizedDescription)
                    }
                    if let codeValue = url?.queryParameters?["code"] {
                        self.code.onNext(codeValue)
                    }
                })
                if #available(iOS 13.0, *) {
                    self.authSession?.presentationContextProvider = self
                }
                self.authSession?.start()
            })
            .disposed(by: rx.disposeBag)

        let tokenRequest = code.flatMapLatest { code -> Observable<RxSwift.Event<Token>> in
            let clientId = Keys.github.appId
            let clientSecret = Keys.github.apiKey
            return self.provider
                .createAccessToken(clientId: clientId,
                                   clientSecret: clientSecret,
                                   code: code,
                                   redirectUri: nil,
                                   state: nil)
                .trackActivity(self.loading)
                .materialize()
        }.share()
        tokenRequest.elements()
            .subscribe(onNext: {[weak self] token in
                guard let `self` = self else { return }
                AuthManager.setToken(token: token)
                self.tokenSaved.onNext(())
            })
            .disposed(by: rx.disposeBag)

        let profileRequest = tokenSaved.flatMapLatest {
            self.provider
                .profile()
                .trackActivity(self.loading)
                .materialize()
        }.share()
        profileRequest.elements()
            .subscribe(onNext: {[weak self] user in
                guard let `self` = self else { return }
                user.save()
                AuthManager.tokenValidated()
                if let login = user.login,
                   let type = AuthManager.shared.token?.type().description {
                    analytics.log(.login(login: login, type: type))
                }
                Application.shared.presentTestScreen(in: Application.shared.window)
            })
            .disposed(by: rx.disposeBag)
        profileRequest.errors()
            .bind(to: serverError)
            .disposed(by: rx.disposeBag)
        serverError
            .subscribe(onNext: {[weak self] error in
                guard let `self` = self else { return }
                // TODO:「lxthyme」💊其它地方的报错是否会走到这里
                AuthManager.removeToken()
            })
            .disposed(by: rx.disposeBag)

        let basicLoginBtnEnabled = BehaviorRelay
            .combineLatest(login, pwd, self.loading.asObservable()) { $0.isNotEmpty && $1.isNotEmpty && !$2 }
            .asDriver(onErrorJustReturn: false)
        let personalLoginBtnEnabled = BehaviorRelay
            .combineLatest(personalToken, self.loading.asObservable()) { $0.isNotEmpty && !$1 }
            .asDriver(onErrorJustReturn: false)

        let hidesBasicLoginView = input.segmentSelection.map { $0 != LoginSegments.basic }
        let hidesPersonalLoginView = input.segmentSelection.map { $0 != LoginSegments.personal }
        let hidesOAuthLoginView = input.segmentSelection.map { $0 != LoginSegments.oAuth }

        return Output(basicLoginBtnEnabled: basicLoginBtnEnabled,
                      personalLoginBtnEnabled: personalLoginBtnEnabled,
                      hidesBasicLoginView: hidesBasicLoginView,
                      hidesPersonalLoginView: hidesPersonalLoginView,
                      hidesOAuthLoginView: hidesOAuthLoginView)
    }
}

class LXLoginVM: LXBaseVM {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let login = BehaviorRelay(value: "")
    let pwd = BehaviorRelay(value: "")
    let personalToken = BehaviorRelay(value: "")
    let code = PublishSubject<String>()
    let tokenSaved = PublishSubject<Void>()
    private var authSession: ASWebAuthenticationSession?
    // MARK: 🛠Life Cycle
    init(with provider: API) {
        super.init(provider: provider)
    }
}

// MARK: 👀Public Actions
@available(iOS 13.0, *)
extension LXLoginVM: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.keyWindow!
    }
}

// MARK: 🔐Private Actions
private extension LXLoginVM {}

