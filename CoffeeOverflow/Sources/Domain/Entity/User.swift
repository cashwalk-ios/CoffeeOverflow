import Foundation

struct User: Codable {
    let slackId: String
    let email: String
    let profileImage: URL?
}
