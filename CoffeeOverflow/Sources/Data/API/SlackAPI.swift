import Foundation

import Moya

enum SlackAPI {
    case lookupUserByEmail(email: String)
    case postChatMessgae(channel: String, threadTS: String, text: String)
    case fetchConversaionsReplies(channel: String, ts: String)
}

extension SlackAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.slack.com/methods")!
        
    }
    
    var path: String {
        switch self {
        case .lookupUserByEmail:
            return "/users.lookupByEmail"
        case .postChatMessgae:
            return "/chat.postMessage"
        case .fetchConversaionsReplies:
            return "/conversations.replies"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postChatMessgae:
            return .post
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .lookupUserByEmail(let email):
            return .requestParameters(
                parameters: ["eamil": email],
                encoding: URLEncoding.queryString
            )
        case .postChatMessgae(let channel, let threadTS, let text):
            return .requestParameters(
                parameters: [
                    "channel": channel,
                    "text": text,
                    "thread_ts": threadTS
                ],
                encoding: URLEncoding.queryString
            )
        case .fetchConversaionsReplies(let channel, let ts):
            return .requestParameters(
                parameters: [
                    "channel": channel,
                    "ts": ts
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        guard let slackBotToken = EnvironmentManager.slackBotToken else { return nil }
        return ["Authorization": "Bearer \(slackBotToken)"]
    }

}
