import Foundation

enum TaskError: LocalizedError, Equatable {
    case emptyTitle
    case maximumCapacityReached
    case taskNotFound
    
    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "El título de la tarea no puede estar vacío."
        case .maximumCapacityReached:
            return "Has alcanzado el límite máximo de 5 tareas prioritarias."
        case .taskNotFound:
            return "La tarea solicitada no existe."
        }
    }
}

struct TaskItem: Identifiable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    let createdAt: Date
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
