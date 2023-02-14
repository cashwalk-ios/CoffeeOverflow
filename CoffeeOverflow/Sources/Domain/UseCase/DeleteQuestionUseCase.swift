import Foundation

import RxSwift

class DeleteQuestionUseCase {

    private let questionsRepository: QuestionsRepository
    
    init(questionsRepository: QuestionsRepository) {
        self.questionsRepository = questionsRepository
    }

    func excute(question: Question) -> Completable {
        return self.questionsRepository.deleteQuestion(question.id)
    }

}
