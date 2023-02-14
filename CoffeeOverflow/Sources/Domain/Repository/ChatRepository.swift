import Foundation

import RxSwift

protocol ChatRepository {
    func postChatMessgae(channel: String, threadTimestamp: String, text: String) -> Completable
}
