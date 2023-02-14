import Foundation

// MARK: - Welcome
struct FetchConversaionsRepliesResponse: Decodable {
    let ok: Bool
    let messages: [Message]
    let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case ok, messages
        case hasMore = "has_more"
    }
}

extension FetchConversaionsRepliesResponse {
    // MARK: - Message
    struct Message: Decodable {
        let type: String
        let subtype: String?
        let text, ts: String
        let botID: String?
        let blocks: [Block]
        let threadTs: String
        let replyCount, replyUsersCount: Int?
        let latestReply: String?
        let replyUsers: [String]?
        let isLocked, subscribed: Bool?
        let user, appID, team: String?
        let botProfile: BotProfile?
        let clientMsgID: String?
        
        enum CodingKeys: String, CodingKey {
            case type, subtype, text, ts
            case botID = "bot_id"
            case blocks
            case threadTs = "thread_ts"
            case replyCount = "reply_count"
            case replyUsersCount = "reply_users_count"
            case latestReply = "latest_reply"
            case replyUsers = "reply_users"
            case isLocked = "is_locked"
            case subscribed, user
            case appID = "app_id"
            case team
            case botProfile = "bot_profile"
            case clientMsgID = "client_msg_id"
        }
    }
    
    // MARK: - Block
    struct Block: Decodable {
        let type, blockID: String
        let elements: [BlockElement]
        
        enum CodingKeys: String, CodingKey {
            case type
            case blockID = "block_id"
            case elements
        }
    }
    
    // MARK: - BlockElement
    struct BlockElement: Decodable {
        let type: String
        let elements: [ElementElementClass]
    }
    
    // MARK: - ElementElementClass
    struct ElementElementClass: Decodable {
        let type: String
        let userID, text: String?
        
        enum CodingKeys: String, CodingKey {
            case type
            case userID = "user_id"
            case text
        }
    }
    
    // MARK: - BotProfile
    struct BotProfile: Decodable {
        let id, appID, name: String
        let icons: Icons
        let deleted: Bool
        let updated: Int
        let teamID: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case appID = "app_id"
            case name, icons, deleted, updated
            case teamID = "team_id"
        }
    }
    
    // MARK: - Icons
    struct Icons: Decodable {
        let image36, image48, image72: String
        
        enum CodingKeys: String, CodingKey {
            case image36 = "image_36"
            case image48 = "image_48"
            case image72 = "image_72"
        }
    }
}

// MARK: - To Domain
extension FetchConversaionsRepliesResponse {
    func asAnswerArray() -> [Answer] {
        return self.messages.map {
            return Answer(answererSlackId: $0.user, text: $0.text)
        }
    }
}
