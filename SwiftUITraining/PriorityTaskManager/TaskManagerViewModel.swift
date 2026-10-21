import Foundation
import Combine

final class TaskManagerViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskItem] = []
    @Published var errorMessage: String?
    
    let maxLimit: Int = 5
    
    func addTask(title: String) throws {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validación 1: Título no vacío
        guard !trimmedTitle.isEmpty else {
            errorMessage = TaskError.emptyTitle.localizedDescription
            throw TaskError.emptyTitle
        }
        
        // Validación 2: Caso límite de capacidad máxima
        guard tasks.count < maxLimit else {
            errorMessage = TaskError.maximumCapacityReached.localizedDescription
            throw TaskError.maximumCapacityReached
        }
        
        let newTask = TaskItem(title: trimmedTitle)
        tasks.append(newTask)
        errorMessage = nil
    }
    
    func toggleTask(id: UUID) throws {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            errorMessage = TaskError.taskNotFound.localizedDescription
            throw TaskError.taskNotFound
        }
        tasks[index].isCompleted.toggle()
    }
    
    func deleteTask(id: UUID) {
        tasks.removeAll(where: { $0.id == id })
    }
    
    func clearAll() {
        tasks.removeAll()
        errorMessage = nil
    }
}
