import Foundation

import Moya
import RxSwift
import RxMoya

class SlackDataSourceImpl: SlackDataSource {
    
    private let provider = MoyaProvider<SlackAPI>()
    
    func lookupUserByEmail(email: String) -> Single<LookupUserByEmailResponse> {
        return self.provider.rx.request(.lookupUserByEmail(email: email))
            .map(LookupUserByEmailResponse.self)
    }
    
    func postChatMessgae(channel: String, threadTS: String, text: String) -> Completable {
        return self.provider.rx.request(.postChatMessgae(
            channel: channel,
            threadTS: threadTS,
            text: text
        ))
        .asCompletable()
    }
    
    func fetchConversaionsReplies(channel: String, ts: String) -> Single<FetchConversaionsRepliesResponse> {
        return self.provider.rx.request(.fetchConversaionsReplies(channel: channel, ts: ts))
            .map(FetchConversaionsRepliesResponse.self)
    }
    
    
}
