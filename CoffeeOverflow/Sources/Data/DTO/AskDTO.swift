//
//  AskDTO.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/13.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct AskDTO: Codable {
    @DocumentID var id: String?
    let acceptedAnswerer: String?
    let channelId: String
    let text: String
    let ts: String
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "document_id"
        case text, ts
        case acceptedAnswerer = "accepted_answerer"
        case channelId = "channel_id"
        case userId = "user_id"
    }
}

// MARK: - To Domain
extension AskDTO {
    func asQuestion() -> Question {
        return Question(
            id: self.id ?? "",
            acceptedAnswerer: self.acceptedAnswerer,
            channelId: self.channelId,
            text: self.text,
            timestamp: self.ts,
            userId: self.userId
        )
    }
}
