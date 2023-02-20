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
        let replyUsers: [String]?
        
        enum CodingKeys: String, CodingKey {
            case replyUsers = "reply_users"
        }
    }
}

// MARK: - To Domain
extension FetchConversaionsRepliesResponse {
    func asAnswerArray() -> [String] {
        return self.messages.first?.replyUsers ?? []
    }
}

/*
 {\"ok\":true,
 \"messages\":[
    {
    \"type\":\"message\",
    \"subtype\":\"bot_message\",
    \"text\":\"<@U03QJE78EGP>: \\uc9c8\\ubb38\\uc9c8\\ubb38\",
    \"ts\":\"1676793389.786689\",
    \"bot_id\":\"B04Q0HNLY0Y\",
    \"blocks\":[{\"type\":\"rich_text\",\"block_id\":\"jK8\",\"elements\":[{\"type\":\"rich_text_section\",\"elements\":[{\"type\":\"user\",\"user_id\":\"U03QJE78EGP\"},{\"type\":\"text\",\"text\":\": \\uc9c8\\ubb38\\uc9c8\\ubb38\"}]}]}],
    \"thread_ts\":\"1676793389.786689\",
    \"reply_count\":1,
    \"reply_users_count\":1,
    \"latest_reply\":\"1676793403.189949\",
    \"reply_users\":[\"U03QJE78EGP\"],
    \"is_locked\":false,
    \"subscribed\":false
    },
    {\"client_msg_id\":\"ff24cbfc-5dc6-46eb-aeb7-01264ef82ed3\",\"type\":\"message\",\"text\":\"\\ub2f5\\ubcc0\\ub2f5\\ubcc0\",\"user\":\"U03QJE78EGP\",\"ts\":\"1676793403.189949\",\"blocks\":[{\"type\":\"rich_text\",\"block_id\":\"09=\",\"elements\":[{\"type\":\"rich_text_section\",\"elements\":[{\"type\":\"text\",\"text\":\"\\ub2f5\\ubcc0\\ub2f5\\ubcc0\"}]}]}],\"team\":\"T01V2RPND5H\",\"thread_ts\":\"1676793389.786689\"}
    ],\"has_more\":false
 
 }
 */
