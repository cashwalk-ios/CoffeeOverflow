//
//  MainReactor.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/06.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import ReactorKit

class MainReactor: Reactor {
    
    private let confirmResponsedCoffeeUseCase: ConfirmResponsedCoffeeUseCase
    private let requestCoffeeUseCase: RequestCoffeeUseCase
    private let fetchMyCoffeePurchaserUseCase: FetchMyCoffeePurchaserUseCase
    
    enum Action {
        case fetch
        case requestCoffee(question: Question)
        case endRequestTimer
        case confirmRecived(question: Question)
    }
    
    enum Mutation {
        case setMySelectedQuestions([Question])
        case setRequestState(Bool)
    }
    
    struct State {
        var coffeePurchasers: [Question] = [Question]()
        var isRequesting: Bool = false // 요청중 상태
    }
    
    let initialState: State = State()
    
    init(confirmResponsedCoffeeUseCase: ConfirmResponsedCoffeeUseCase,
         requestCoffeeUseCase: RequestCoffeeUseCase,
         fetchMyCoffeePurchaserUseCase: FetchMyCoffeePurchaserUseCase
    ) {
        self.confirmResponsedCoffeeUseCase = confirmResponsedCoffeeUseCase
        self.requestCoffeeUseCase = requestCoffeeUseCase
        self.fetchMyCoffeePurchaserUseCase = fetchMyCoffeePurchaserUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            return fetchMyCoffeePurchaserUseCase.excute()
                .map { Mutation.setMySelectedQuestions($0) }
                .asObservable()
        case let .requestCoffee(question):
            return requestCoffeeUseCase.excute(question: question)
                .andThen(.just(.setRequestState(true)))
        case .endRequestTimer:
            return .just(.setRequestState(false))
        case let .confirmRecived(question):
            var newQuestions = currentState.coffeePurchasers.filter { $0.id != question.id } 
            return confirmResponsedCoffeeUseCase.excute(question: question)
                .andThen(.just(.setMySelectedQuestions(newQuestions)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        
        case let .setMySelectedQuestions(question):
            newState.coffeePurchasers = question
        case let .setRequestState(state):
            newState.isRequesting = state
        }
        
        return newState
    }
}
