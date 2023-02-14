import Foundation

import RxSwift

class ChatRepositoryImpl: ChatRepository {

    private let slackDataSource: SlackDataSource

    init(slackDataSource: SlackDataSource) {
        self.slackDataSource = slackDataSource
    }

    func postChatMessgae(
        channel: String,
        threadTimestamp: String,
        text: String
    ) -> Completable {
        self.slackDataSource.postChatMessgae(
            channel: channel,
            threadTS: threadTimestamp,
            text: text
        )
    }

}
