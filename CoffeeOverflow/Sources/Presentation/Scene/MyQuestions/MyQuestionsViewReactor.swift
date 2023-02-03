//
//  MyQuestionsViewReactor.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/01/31.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import ReactorKit

class MyQuestionsViewReactor: Reactor {
  
    enum Action {
        
    }
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    struct State {
        
        var isLoading: Bool = false
    }
    
    let initialState: State = State()
    private var useCase: MyQuestionsUseCase

    init(useCase: MyQuestionsUseCase) {
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        
        case let .setLoading(value):
            newState.isLoading = value
        }
        
        return newState
    }
}
