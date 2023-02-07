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

class LoginViewController: UIViewController, View {

    var disposeBag = DisposeBag()
    
    fileprivate var loginView: LoginView {
        return self.view as! LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(reactor: LoginReactor, view: MainViewController) {
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
        return
    }
}
