import Foundation
import FirebaseFirestore

enum ViewState: Equatable {
    case idle
    case loading
    case success
    case error(String)
}

struct Habit: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var userId: String
    var title: String
    var description: String
    var isCompleted: Bool
    var createdAt: Date
}
