//
//  MainReactor.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/06.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

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
        case startTimer
    }
    
    enum Mutation {
        case setMySelectedQuestions([Question])
        case setRequestState(Bool)
        case setSelectedQuestion(Question)
        case setisShowQuestionView(Bool)
        case setTimer(Int)
        case setLoading(Bool)
    }
    
    struct State {
        @Pulse var coffeePurchasers: [Question] = [Question]()
        var isRequesting: Bool = false // 요청중 상태
        @Pulse var selectedQuestion: Question?
        var isShowQuestionView: Bool = false
        var remainTime: String = ""
        var loaded: Bool = false
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
            let coffees =  fetchMyCoffeePurchaserUseCase.excute()
                .map { Mutation.setMySelectedQuestions($0) }
                .asObservable()
            
            return Observable.concat([
                coffees,
                .just(.setLoading(true))
            ])
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
        case .startTimer:
            return self.activateTimer()
                .map { Mutation.setTimer($0) }
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
        case let .setTimer(time):
            newState.remainTime = secondsToMinutesSecondString(time)
            if time <= 0 {
                newState.isRequesting = false
            }
        case let .setLoading(value):
            newState.loaded = value
        }
        return newState
    }
    
    private func secondsToMinutesSecondString(_ seconds: Int) -> String {
        let min = (seconds % 3600) / 60
        let sec = ((seconds % 3600) % 60)
        return String(format: "%02d:%02d", min, sec)
    }
}

extension MainReactor {

    private func activateTimer() -> Observable<Int> {
        return Observable<Int>.create { observable in
            var leftTime = 300
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                leftTime -= 1
                observable.onNext(leftTime)
                if leftTime <= 0 {
                    timer.invalidate()
                }
            })
            return Disposables.create()
        }
    }

}
