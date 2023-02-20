//
//  LoginViewController.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import ReactorKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import RxGesture
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController, View {

    var disposeBag = DisposeBag()

    private var mainViewController: MainViewController
    private var myQuestionsViewController: MyQuestionsViewController
    
    fileprivate var loginView: LoginView {
        return self.view as! LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(reactor: LoginReactor, mainViewController: MainViewController, myQuestionsViewController: MyQuestionsViewController) {
        self.mainViewController = mainViewController
        self.myQuestionsViewController = myQuestionsViewController
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LoginView()
    }
    
    func bind(reactor: LoginReactor) {
        
        self.loginView.loginButton.rx.tap
            .flatMap { return Single.create { single in

                Task { do {
//                    let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: self)
//                    self.myQuestionsViewController.modalPresentationStyle = .fullScreen
//                    self.present(self.mainViewController, animated: true)
                    self.myQuestionsViewController.isModalInPresentation = true
                    self.present(self.myQuestionsViewController, animated: false)
                    
//                    self.mainViewController.modalPresentationStyle = .fullScreen
//                    self.present(self.mainViewController, animated: true)
//                    single(.success(result))
                } catch {
                    single(.failure(error))
                }}

                return Disposables.create()
            }}
            .map { Reactor.Action.googleSignin(result: $0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isSigninSuccess }
            .subscribe(onNext: { [weak self] isSuccess in
                guard let self else { return }
                self.modalPresentationStyle = .fullScreen
                self.present(self.mainViewController, animated: true)
            })
            .disposed(by: self.disposeBag)
        
    }
}
