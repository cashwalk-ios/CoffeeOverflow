import Foundation

import RxSwift

protocol QuestionsRepository {
    func putQuestion(_ question: Question) throws
    func deleteQuestion(_ questionId: String) -> Completable
    func fetchQuestions() -> Single<[Question]>
    func fetchAnswerOfQuestion(channel: String, timestamp: String) -> Single<[String]>
}
