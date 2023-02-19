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
        case requestCoffee
        case endRequestTimer
        case confirmRecived
        case select(index: Int)
    }
    
    enum Mutation {
        case setMySelectedQuestions([Question])
        case setRequestState(Bool)
        case setSelectedQuestion(Question)
    }
    
    struct State {
        var coffeePurchasers: [Question] = [Question]()
        var isRequesting: Bool = false // 요청중 상태
        var selectedQuestion: Question?
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
        case .requestCoffee:
            guard let question = currentState.selectedQuestion else { return .empty()}
            return requestCoffeeUseCase.excute(question: question)
                .andThen(.just(.setRequestState(true)))
        case .endRequestTimer:
            return .just(.setRequestState(false))
        case .confirmRecived:
            guard let question = currentState.selectedQuestion else { return .empty()}
            let newQuestions = currentState.coffeePurchasers.filter { $0.id != question.id }
            return confirmResponsedCoffeeUseCase.excute(question: question)
                .andThen(.just(.setMySelectedQuestions(newQuestions)))
        case let.select(index):
            let selectedQuestion = currentState.coffeePurchasers[index]
            return .just(.setSelectedQuestion(selectedQuestion))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        
        case let .setMySelectedQuestions(question):  
            newState.coffeePurchasers = question
        case let .setRequestState(state):
            newState.isRequesting = state
        case let .setSelectedQuestion(question):
            newState.selectedQuestion = question
        }
        
        return newState
    }
}
