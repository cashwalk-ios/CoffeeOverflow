//
//  LoginReactor.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class LoginReactor: Reactor {
    
    private let signInUsecase: SignInUseCase
    private let checkSingInUsecase: CheckIsSignedInUseCase
    
    private var disposeBag = DisposeBag()
    
    enum Action {
        case checkSingIn
        case login
    }
    
    enum Mutation {
        case setLoginState(Bool)
    }
    
    struct State {
        var isLogin: Bool = false
    }
    
    let initialState: State = State()
    
    init(signInUsecase: SignInUseCase, checkSingInUsecase: CheckIsSignedInUseCase) {
        self.signInUsecase = signInUsecase
        self.checkSingInUsecase = checkSingInUsecase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .checkSingIn:
            let isLogined = checkSingInUsecase.excute()
            return .just(.setLoginState(isLogined))
            
        case .login:
            return self.signInUsecase.excute(email: "choi.yeaju@cashwalk.io")
                .andThen(.just(Mutation.setLoginState(true)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case let .setLoginState(isLogin):
            newState.isLogin = isLogin
        }
        return newState
    }
}
