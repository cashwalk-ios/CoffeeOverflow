import Foundation

struct FetchConversaionsRepliesResponse: Decodable {
    let messages: [Message]
    let hasMore, ok: Bool
    let responseMetadata: ResponseMetadata

    enum CodingKeys: String, CodingKey {
        case messages
        case hasMore = "has_more"
        case ok
        case responseMetadata = "response_metadata"
    }
}

// MARK: - Message
extension FetchConversaionsRepliesResponse {
    struct Message: Decodable {
        let type, user, text, threadTs: String
        let replyCount: Int?
        let subscribed: Bool?
        let lastRead: String?
        let unreadCount: Int?
        let ts: String
        let parentUserID: String?
        
        enum CodingKeys: String, CodingKey {
            case type, user, text
            case threadTs = "thread_ts"
            case replyCount = "reply_count"
            case subscribed
            case lastRead = "last_read"
            case unreadCount = "unread_count"
            case ts
            case parentUserID = "parent_user_id"
        }
    }

    struct ResponseMetadata: Decodable {
        let nextCursor: String

        enum CodingKeys: String, CodingKey {
            case nextCursor = "next_cursor"
        }
    }
}
