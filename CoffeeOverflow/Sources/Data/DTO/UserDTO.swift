//
//  UserDTO.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/13.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct UserDTO: Codable {
    @DocumentID var id: String?
    
    let email: String
    let profileImage: String
    let slackId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "document_id"
        case email
        case profileImage = "profile_image"
        case slackId = "slack_id"
    }
}
