import Foundation

import RxSwift

protocol UserReposiotry {
    func insertUser(_ user: User) throws
    func lookupSlackUserByEmail(email: String) -> Single<User>
    func saveSlackId(_ slackId: String)
    func fetchSlackId() -> String?
}
