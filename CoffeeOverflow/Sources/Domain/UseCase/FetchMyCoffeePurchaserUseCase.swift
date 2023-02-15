import Foundation

import RxSwift

class FetchMyCoffeePurchaserUseCase {

    let questionsRepository: QuestionsRepository
    let userReposiotry: UserReposiotry

    init(questionsRepository: QuestionsRepository, userReposiotry: UserReposiotry) {
        self.questionsRepository = questionsRepository
        self.userReposiotry = userReposiotry
    }

    func excute() -> Single<[User]> {
        self.questionsRepository.fetchQuestions()
            .map { self.filterMyAnsweredQuestion($0) }
            .flatMap { self.convertQuestionsToUsers(questions: $0) }
    }
    
}

extension FetchMyCoffeePurchaserUseCase {

    private func filterMyAnsweredQuestion(_ questions: [Question]) -> [Question] {
        let mySlackId = self.userReposiotry.fetchMySlackId()
        return questions.filter {
            $0.acceptedAnswerer == mySlackId
        }
    }

    private func convertQuestionsToUsers(questions: [Question]) -> Single<[User]> {
        return self.userReposiotry.fetchUsers()
            .map { users in
                questions.map { question in
                    users.first { $0.slackId == question.userId }
                }
                .compactMap { $0 }
            }
    }

}
