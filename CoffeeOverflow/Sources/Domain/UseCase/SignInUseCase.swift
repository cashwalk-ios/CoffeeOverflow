import Foundation

import RxSwift

class SignInUseCase {
    
    private let userRepository: UserReposiotry
    
    init(userRepository: UserReposiotry) {
        self.userRepository = userRepository
    }
    
    func excute(email: String) -> Completable {
        self.userRepository.lookupSlackUserByEmail(email: email)
            .map {
                try self.userRepository.insertUser($0)
                self.userRepository.saveSlackId($0.slackId)
            }
            .asCompletable()
    }

}