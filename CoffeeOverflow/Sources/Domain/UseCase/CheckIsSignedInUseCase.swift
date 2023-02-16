import Foundation

import RxSwift

class CheckIsSignedInUseCase {
    
    private let userRepository: UserReposiotry
    
    init(userRepository: UserReposiotry) {
        self.userRepository = userRepository
    }
    
    func excute() -> Bool {
        return self.userRepository.fetchMySlackId() != nil
    }

}
