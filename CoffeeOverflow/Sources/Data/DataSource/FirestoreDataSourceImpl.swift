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

    private let db = Firestore.firestore()
    
    func selectAnswerer(question: QuestionDTO) async throws {
        guard let oid = question.id else { return }
        try await db.collection(Collection.asks.rawValue).document(oid).setData(from: question, encoder: Firestore.Encoder())
    }
    
    func deleteAsk(question: QuestionDTO) async throws{
        guard let id = question.id else { return }
        try await db.collection(Collection.asks.rawValue).document(id).delete()
        
    }
    
    func insertUser(user: UserDTO) async throws{
            try await db.collection(Collection.users.rawValue).addDocument(from: user, encoder: Firestore.Encoder())
    }
    
    func fetchAsks() async throws -> [QuestionDTO] {
        let snapshot = try await db.collection(Collection.asks.rawValue).getDocuments()
        return snapshot.documents.compactMap { document in
            try? document.data(as: QuestionDTO.self)
        }
    }
}


