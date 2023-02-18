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
        
    }
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    struct State {
        
        var isLoading: Bool = false
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
