import Foundation

struct EnvironmentManager {
    static let slackBotToken = Self.getValue(key: "SLACK_BOT_TOKEN")
}

// MARK: - Get Value
extension EnvironmentManager {
    public static func getValue(key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
