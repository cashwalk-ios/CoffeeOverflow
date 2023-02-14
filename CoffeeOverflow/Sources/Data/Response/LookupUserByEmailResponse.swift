import Foundation

struct LookupUserByEmailResponse: Decodable {
    let ok: Bool
    let user: User
}

extension LookupUserByEmailResponse {
    struct User: Decodable {
        let id, teamID, name: String
        let deleted: Bool
        let color, realName, tz, tzLabel: String
        let tzOffset: Int
        let profile: Profile
        let isAdmin, isOwner, isPrimaryOwner, isRestricted: Bool
        let isUltraRestricted, isBot: Bool
        let updated: Int
        let isAppUser: Bool
        let whoCanShareContactCard: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case teamID = "team_id"
            case name, deleted, color
            case realName = "real_name"
            case tz
            case tzLabel = "tz_label"
            case tzOffset = "tz_offset"
            case profile
            case isAdmin = "is_admin"
            case isOwner = "is_owner"
            case isPrimaryOwner = "is_primary_owner"
            case isRestricted = "is_restricted"
            case isUltraRestricted = "is_ultra_restricted"
            case isBot = "is_bot"
            case updated
            case isAppUser = "is_app_user"
            case whoCanShareContactCard = "who_can_share_contact_card"
        }
    }

    struct Profile: Decodable {
        let avatarHash, statusText, statusEmoji, realName: String
        let displayName, realNameNormalized, displayNameNormalized, email: String
        let image24, image32, image48, image72: String
        let image192, image512: String
        let team: String
        
        enum CodingKeys: String, CodingKey {
            case avatarHash = "avatar_hash"
            case statusText = "status_text"
            case statusEmoji = "status_emoji"
            case realName = "real_name"
            case displayName = "display_name"
            case realNameNormalized = "real_name_normalized"
            case displayNameNormalized = "display_name_normalized"
            case email
            case image24 = "image_24"
            case image32 = "image_32"
            case image48 = "image_48"
            case image72 = "image_72"
            case image192 = "image_192"
            case image512 = "image_512"
            case team
        }
    }
}
