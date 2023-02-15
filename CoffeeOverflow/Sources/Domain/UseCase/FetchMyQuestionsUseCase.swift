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
            .map { self.filterMyActivatingQuestions($0) }
            .flatMap { Single.zip($0.map { self.zipWithAnswerers(question: $0) }) }
    }

}

extension FetchMyQuestionsUseCase {

    private func filterMyActivatingQuestions(_ questions: [Question]) -> [Question] {
        let mySlackId = self.userReposiotry.fetchMySlackId()
        return questions.filter {
            $0.acceptedAnswerer == nil && $0.userId == mySlackId
        }
    }

    private func zipWithAnswerers(question: Question) -> Single<Question> {
        return self.questionsRepository.fetchAnswerOfQuestion(
            channel: question.channelId,
            timestamp: question.timestamp
        )
        .flatMap { self.convertAnswersToUsers(answers: $0) }
        .map {
            var newQuestion = question
            newQuestion.answerer = $0
            return newQuestion
        }
    }
    
    private func convertAnswersToUsers(answers: [Answer]) -> Single<[User]> {
        return self.userReposiotry.fetchUsers()
            .map { users in
                answers.map { answer in
                    users.first { $0.slackId == answer.answererSlackId }
                }
                .compactMap { $0 }
            }
    }

}
