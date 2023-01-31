
import Foundation
import ReactorKit

class MockReactor: Reactor {
  
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
