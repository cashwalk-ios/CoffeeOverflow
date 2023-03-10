import Foundation

import RxSwift

class RequestCoffeeUseCase {

    private let chatRepository: ChatRepository

    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository
    }

    func excute(question: Question) -> Completable {
        guard let acceptedAnswerer = question.acceptedAnswerer else { return Completable.error(ChatError.noAcceptedAnswererError) }
        return self.chatRepository.postChatMessgae(
            channel: question.channelId,
            threadTimestamp: question.timestamp,
            text: "<@\(question.user.slackId)>님! 채택해주신 답변자 <@\(acceptedAnswerer.slackId)>님이 커피를 요청하셨어요! ☕️"
        )
    }

}
