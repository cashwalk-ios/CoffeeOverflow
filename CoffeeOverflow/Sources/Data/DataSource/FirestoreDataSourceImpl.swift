//
//  FirestoreDataSourceImpl.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/13.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import RxSwift

enum Collection: String {
    case asks
    case users
}

class FirestoreDataSourceImpl: FirestoreDataSource {

    let db = Firestore.firestore()
    
    func selectAnswerer(question: QuestionDTO) async {
        guard let oid = question.id else { return }
        do { try await db.collection(Collection.asks.rawValue).document(oid).setData(from: question, encoder: Firestore.Encoder())
        } catch { }
    }
    
    func deleteQuestion(question: QuestionDTO) async {
        guard let id = question.id else { return }
        do {
            try await db.collection(Collection.asks.rawValue).document(id).delete()
        } catch { }
    }
    
    func insertUser(user: UserDTO) async {
        do {
            try await db.collection(Collection.users.rawValue).addDocument(from: user, encoder: Firestore.Encoder())
        } catch { }
    }
    
    func fetchQuestions() async throws -> [QuestionDTO]? {
        guard let snapshot = try? await db.collection(Collection.asks.rawValue).getDocuments() else { return nil }
        return snapshot.documents.compactMap { document in
            try? document.data(as: QuestionDTO.self)
        }
    }
}


