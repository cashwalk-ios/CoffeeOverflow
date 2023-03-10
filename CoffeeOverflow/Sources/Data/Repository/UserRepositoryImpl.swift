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
            email: user.email ?? "",
            profileImage: user.profileImage?.absoluteString ?? "",
            slackId: user.slackId
        ))
    }

    func lookupSlackUserByEmail(email: String) -> Single<User> {
        return self.slackDataSource.lookupUserByEmail(email: email)
            .map { $0.asUser() }
    }

    func saveMySlackId(_ slackId: String) {
        self.userDefaultsDataSource.saveSlackId(slackId)
    }

    func fetchMySlackId() -> String? {
        return self.userDefaultsDataSource.fetchSlackId()
    }

    func fetchUsers() -> Single<[User]> {
        return Single.create { single in

            Task { do {
                let users = try await self.firestoreDataSource.fetchUsers()
                single(.success(users.map { $0.asUser() }))
            } catch {
                single(.failure(error))
            }}

            return Disposables.create()
        }
    }

}
