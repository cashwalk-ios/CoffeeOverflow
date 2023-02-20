import Foundation

import RxSwift

class FetchMyCoffeePurchaserUseCase {

    let questionsRepository: QuestionsRepository
    let userReposiotry: UserReposiotry

    init(questionsRepository: QuestionsRepository, userReposiotry: UserReposiotry) {
        self.questionsRepository = questionsRepository
        self.userReposiotry = userReposiotry
    }

    func excute() -> Single<[Question]> {
        self.questionsRepository.fetchQuestions()
            .map { self.filterMyAnsweredQuestion($0) }
            .flatMap { self.zipWithSlackUser(questions: $0) }
    }
    
}

extension FetchMyCoffeePurchaserUseCase {

    private func filterMyAnsweredQuestion(_ questions: [Question]) -> [Question] {
        let mySlackId = self.userReposiotry.fetchMySlackId()
        return questions.filter {
            $0.acceptedAnswerer?.slackId == mySlackId
        }
    }

    private func zipWithSlackUser(questions: [Question]) -> Single<[Question]> {
        return self.userReposiotry.fetchUsers()
            .map { users in
                questions.map { question in
                    guard let user = users.first(where: { $0.slackId == question.user.slackId }) else { return question }
                    var newQuestion = question
                    newQuestion.user = user
                    return newQuestion
                }
            }
    }

}
