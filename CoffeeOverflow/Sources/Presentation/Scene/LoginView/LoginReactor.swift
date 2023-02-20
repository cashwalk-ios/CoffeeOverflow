//
//  LoginReactor.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import ReactorKit
import GoogleSignIn

class LoginReactor: Reactor {

    private let signInUseCase: SignInUseCase

    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }
    
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

        case .googleSignin(let result):
            return self.signInUseCase.excute(email: result.user.profile?.email ?? "")
                .andThen(.just(Mutation.setSigninReslut(isSuccess: true)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setSigninReslut(let isSuccess):
            newState.isSigninSuccess = isSuccess
        }
        return newState
    }

}
