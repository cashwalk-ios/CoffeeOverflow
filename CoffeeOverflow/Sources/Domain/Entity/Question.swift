import Foundation

struct Question {
    let id: String
    var acceptedAnswerer: String?
    let channelId: String
    let text: String
    let timestamp: String
    let userId: String
    var answerer: [User]?
}
