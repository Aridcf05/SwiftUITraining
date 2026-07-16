import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    
    // Exponer la lista de tareas con @Published
    @Published var tasks: [TrainingTask] = [
        TrainingTask(title: "Completar la estructura MVVM", isCompleted: true),
        TrainingTask(title: "Configurar el flujo modal con sheet", isCompleted: false),
        TrainingTask(title: "Diseñar la vista de creación de tareas", isCompleted: false)
    ]
    
    // Métodos con nombres de intención claros
    func addTask(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }
        let newTask = TrainingTask(title: trimmedTitle)
        tasks.append(newTask)
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func toggleTaskCompletion(task: TrainingTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}
