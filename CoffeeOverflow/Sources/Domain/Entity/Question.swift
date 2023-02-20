import Foundation

struct Question {
    let id: String
    var acceptedAnswerer: User?
    let channelId: String
    let text: String
    let timestamp: String
    var user: User
    var answerer: [User]?
}
