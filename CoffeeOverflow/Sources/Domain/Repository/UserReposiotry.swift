import Foundation

import RxSwift

protocol UserReposiotry {
    func insertUser(_ user: User) throws
    func lookupSlackUserByEmail(email: String) -> Single<User>
    func saveMySlackId(_ slackId: String)
    func fetchMySlackId() -> String?
    func fetchUsers() -> Single<[User]>
}
