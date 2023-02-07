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
    
    enum Action {
        
    }
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    struct State {
        
        var isLoading: Bool = false
    }
    
    let initialState: State = State()
    private var useCase: MockUseCase

    init(useCase: MockUseCase) {
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
