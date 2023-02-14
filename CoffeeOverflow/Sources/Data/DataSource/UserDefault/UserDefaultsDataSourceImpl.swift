import Foundation

class UserDefaultsDataSourceImpl: UserDefaultsDataSource {

    private let userDefaults = UserDefaults.standard

    func saveSlackId(_ slackId: String) {
        self.userDefaults.set(slackId, forKey: "SLACK_ID")
    }
    
    func fetchSlackId() -> String? {
        return self.userDefaults.string(forKey: "SLACK_ID")
    }

}
