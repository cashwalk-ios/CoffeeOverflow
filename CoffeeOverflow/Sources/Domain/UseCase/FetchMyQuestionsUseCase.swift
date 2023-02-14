import Foundation

import RxSwift

class FetchMyQuestionsUseCase {

    private let userReposiotry: UserReposiotry
    private let questionsRepository: QuestionsRepository

    init(userReposiotry: UserReposiotry, questionsRepository: QuestionsRepository) {
        self.userReposiotry = userReposiotry
        self.questionsRepository = questionsRepository
    }

    func excute() -> Single<[Question]> {
        self.questionsRepository.fetchQuestions()
            .map { $0.filter(self.checkIsMyActivatingQuestion(question:)) }
            .flatMap { Single.zip($0.map { self.zipWithAnswerers(question: $0) }) }
    }

}

extension FetchMyQuestionsUseCase {

    private func checkIsMyActivatingQuestion(question: Question) -> Bool {
        guard let mySlackId = self.userReposiotry.fetchSlackId() else { return false }
        return question.acceptedAnswerer == nil && question.userId == mySlackId
    }

    private func zipWithAnswerers(question: Question) -> Single<Question> {
        self.questionsRepository.fetchAnswerOfQuestion(channel: question.channelId, timestamp: question.timestamp)
            .flatMap { Single.zip($0.map { self.convertAnswerToUser(answer: $0) }) }
            .map {
                var newQuestion = question
                newQuestion.answerer = $0.compactMap { $0 }
                return newQuestion
            }
    }
    
    private func convertAnswerToUser(answer: Answer) -> Single<User?> {
        self.userReposiotry.fetchUsers()
            .map { $0.filter { $0.slackId == answer.answererSlackId }.first }
            
    }

}
