import Foundation

protocol UserDefaultsDataSource {
    func saveSlackId(_ slackId: String)
    func fetchSlackId() -> String?
}
