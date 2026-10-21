import SwiftUI

struct TaskManagerView: View {
    @StateObject private var viewModel = TaskManagerViewModel()
    @State private var taskInput: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Entrada de texto y botón
                HStack(spacing: 12) {
                    TextField("Nueva tarea prioritaria...", text: $taskInput)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("txt_task_input")
                    
                    Button("Agregar") {
                        do {
                            try viewModel.addTask(title: taskInput)
                            taskInput = ""
                        } catch {
                            // El mensaje ya queda en viewModel.errorMessage
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityIdentifier("btn_add_task")
                }
                .padding(.horizontal)
                
                // Mensaje de Error
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("txt_error_banner")
                        .padding(.horizontal)
                }
                
                // Lista de Tareas
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                            
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            try? viewModel.toggleTask(id: task.id)
                        }
                        .accessibilityIdentifier("row_task_\(task.title)")
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let task = viewModel.tasks[index]
                            viewModel.deleteTask(id: task.id)
                        }
                    }
                }
                .accessibilityIdentifier("list_tasks")
            }
            .navigationTitle("Tareas Prioritarias")
        }
    }
}

#Preview {
    TaskManagerView()
}
