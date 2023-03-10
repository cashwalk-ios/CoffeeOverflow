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
    let email: String
    let profileImage: String
    let slackId: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case profileImage = "profile_image"
        case slackId = "slack_id"
    }
}

// MARK: - To Domain
extension UserDTO {
    func asUser() -> User {
        return User(
            slackId: self.slackId,
            email: self.email,
            profileImage: URL(string: self.profileImage)
        )
    }
}
