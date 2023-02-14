import Foundation

import RxSwift

protocol SlackDataSource {
    func lookupUserByEmail(email: String) -> Single<LookupUserByEmailResponse>
    func postChatMessgae(channel: String, threadTS: String, text: String) -> Completable
    func fetchConversaionsReplies(channel: String, ts: String) -> Single<FetchConversaionsRepliesResponse>
}
