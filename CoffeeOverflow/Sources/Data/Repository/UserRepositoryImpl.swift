import Foundation

import RxSwift

class UserRepositoryImpl: UserReposiotry {

    private let slackDataSource: SlackDataSource
    private let firestoreDataSource: FirestoreDataSource
    private let userDefaultsDataSource: UserDefaultsDataSource
    
    init(
        slackDataSource: SlackDataSource,
        firestoreDataSource: FirestoreDataSource,
        userDefaultsDataSource: UserDefaultsDataSource
    ) {
        self.slackDataSource = slackDataSource
        self.firestoreDataSource = firestoreDataSource
        self.userDefaultsDataSource = userDefaultsDataSource
    }
    
    
    func insertUser(_ user: User) throws {
        try self.firestoreDataSource.insertUser(user: UserDTO(
            id: user.slackId,
            email: user.email,
            profileImage: user.profileImage?.absoluteString ?? "",
            slackId: user.slackId
        ))
    }

    func lookupSlackUserByEmail(email: String) -> Single<User> {
        return self.slackDataSource.lookupUserByEmail(email: email)
            .map { $0.asUser() }
    }

    func saveSlackId(_ slackId: String) {
        self.userDefaultsDataSource.saveSlackId(slackId)
    }

    func fetchSlackId() -> String? {
        return self.userDefaultsDataSource.fetchSlackId()
    }

}
