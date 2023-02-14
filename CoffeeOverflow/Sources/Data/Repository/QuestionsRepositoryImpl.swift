import Foundation

import RxSwift

class QuestionsRepositoryImpl: QuestionsRepository {
    
    private let firestoreDataSource: FirestoreDataSource

    init(firestoreDataSource: FirestoreDataSource) {
        self.firestoreDataSource = firestoreDataSource
    }
    
    func putQuestion(_ question: Question) throws {
        try self.firestoreDataSource.putAsk(ask: AskDTO(
            acceptedAnswerer: question.acceptedAnswerer,
            channelId: question.channelId,
            isAccepted: question.isAccepted,
            text: question.text,
            ts: question.timestamp,
            userId: question.userId
        ))
    }
    
    func deleteQuestion(_ questionId: String) -> Completable {
        return Completable.create { completable in

            Task { do {
                try await self.firestoreDataSource.deleteAsk(askId: questionId)
                completable(.completed)
            } catch {
                completable(.error(error))
            }}

            return Disposables.create()
        }
    }
    
    func fetchQuestions() -> Single<[Question]> {
        return Single.create { single in

            Task { do {
                let asks = try await self.firestoreDataSource.fetchAsks()
                single(.success(asks.map { $0.asQuestion() }))
            } catch {
                single(.failure(error))
            }}

            return Disposables.create()
        }
    }
    
    
}
