import Foundation

import RxSwift

class SelectionAnswerUseCase {

    private let userReposiotry: UserReposiotry
    private let chatRepository: ChatRepository
    private let questionsRepository: QuestionsRepository

    init(userReposiotry: UserReposiotry, chatRepository: ChatRepository, questionsRepository: QuestionsRepository) {
        self.userReposiotry = userReposiotry
        self.chatRepository = chatRepository
        self.questionsRepository = questionsRepository
    }

    func excute(question: Question, answer: User) -> Completable {
        var answeredQuestion = question
        answeredQuestion.acceptedAnswerer = answer
        do {
            try self.questionsRepository.putQuestion(answeredQuestion)
            return self.chatRepository.postChatMessgae(
                channel: question.channelId,
                threadTimestamp: question.timestamp,
                text: "<@\(answer.slackId)>님 의 답변이 채택되었어요! 🎉"
            )
        } catch {
            return Completable.error(error)
        }
    }

}
