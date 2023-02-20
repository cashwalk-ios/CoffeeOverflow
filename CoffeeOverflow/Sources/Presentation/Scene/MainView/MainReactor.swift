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
    private let fetchMyQuestionsUseCase: FetchMyQuestionsUseCase
    
    enum Action {
        case fetchMyQuestion
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
        case setisShowQuestionView(Bool)
    }
    
    struct State {
        var coffeePurchasers: [Question] = [Question]()
        var isRequesting: Bool = false // 요청중 상태
        var selectedQuestion: Question?
        var isShowQuestionView: Bool = false
    }
    
    let initialState: State = State()
    
    init(confirmResponsedCoffeeUseCase: ConfirmResponsedCoffeeUseCase,
         requestCoffeeUseCase: RequestCoffeeUseCase,
         fetchMyCoffeePurchaserUseCase: FetchMyCoffeePurchaserUseCase,
         fetchMyQuestionsUseCase : FetchMyQuestionsUseCase) {
        self.confirmResponsedCoffeeUseCase = confirmResponsedCoffeeUseCase
        self.requestCoffeeUseCase = requestCoffeeUseCase
        self.fetchMyCoffeePurchaserUseCase = fetchMyCoffeePurchaserUseCase
        self.fetchMyQuestionsUseCase = fetchMyQuestionsUseCase
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
        case .fetchMyQuestion:
            return fetchMyQuestionsUseCase.excute()
                .map { question in
                    Mutation.setisShowQuestionView(question.count != 0) }
                .asObservable()
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
        case let .setisShowQuestionView(isShow):
            newState.isShowQuestionView = isShow
        }
        
        return newState
    }
}
