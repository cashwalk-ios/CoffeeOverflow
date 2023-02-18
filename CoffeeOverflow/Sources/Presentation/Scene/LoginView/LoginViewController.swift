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
import RxGesture
import RxCocoa

class LoginViewController: UIViewController, View {

    var disposeBag = DisposeBag()
    private var mainVC: MainViewController
    
    fileprivate var loginView: LoginView {
        return self.view as! LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(reactor: LoginReactor, view: MainViewController) {
        self.mainVC = view
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LoginView()
        reactor?.action.onNext(.checkSingIn)
    }
    
    func bind(reactor: LoginReactor) {

        
        loginView.loginButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in Reactor.Action.login }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.isLogin)
            .filter { $0 }
            .withUnretained(self)
            .subscribe { vc, _ in
                DispatchQueue.main.async {
                    vc.mainVC.modalPresentationStyle = .overFullScreen
                    vc.present(vc.mainVC, animated: true)
                }
                
            }.disposed(by: disposeBag)
    }
}
