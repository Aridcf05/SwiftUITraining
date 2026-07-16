import Foundation

struct TrainingTask: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var isCompleted: Bool = false
}
