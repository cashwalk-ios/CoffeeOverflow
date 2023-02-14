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
    
    func putAsk(ask: AskDTO) throws {
        guard let id = ask.id else { return }
        try db.collection(Collection.asks.rawValue).document(id).setData(from: ask, encoder: Firestore.Encoder())
    }
    
    func deleteAsk(askId: String) async throws {
        try await db.collection(Collection.asks.rawValue).document(askId).delete()
    }
    
    func insertUser(user: UserDTO) throws {
        _ = try db.collection(Collection.users.rawValue).addDocument(from: user, encoder: Firestore.Encoder())
    }
    
    func fetchAsks() async throws -> [AskDTO] {
        let snapshot = try await db.collection(Collection.asks.rawValue).getDocuments()
        return snapshot.documents.compactMap { document in
            try? document.data(as: AskDTO.self)
        }
    }
}


