import SwiftUI

struct TaskDetailView: View {
    // Pasos 2: Leemos el mismo ViewModel global
    @EnvironmentObject var viewModel: TaskViewModel
    
    // Recibimos solo el ID de la tarea para buscarla en el estado global
    let taskID: UUID
    
    // Propiedad computada para encontrar la tarea en tiempo real
    private var currentTask: TrainingTask? {
        viewModel.tasks.first(where: { $0.id == taskID })
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            if let task = currentTask {
                VStack(spacing: 24) {
                    
                    // Tarjeta de información de la tarea
                    VStack(spacing: 16) {
                        Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "doc.plaintext.fill")
                            .font(.system(size: 60))
                            .foregroundColor(task.isCompleted ? .green : .blue)
                        
                        Text(task.title)
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                        
                        Text(task.isCompleted ? "Estado: Completada" : "Estado: Pendiente")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(task.isCompleted ? .green : .orange)
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 3)
                    
                    // Pasos 4: Permitir marcar como completada/pendiente desde el detalle
                    Button(action: {
                        viewModel.toggleTaskCompletion(task: task)
                    }) {
                        HStack {
                            Image(systemName: task.isCompleted ? "arrow.uturn.backward" : "checkmark.circle.fill")
                            Text(task.isCompleted ? "Marcar como Pendiente" : "Marcar como Completada")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(task.isCompleted ? Color.orange : Color.blue)
                        .cornerRadius(12)
                    }
                    
                    Spacer()
                }
                .padding(24)
            } else {
                Text("Error: La tarea no existe.")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Detalle de Tarea")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // Agregamos la inyección en el Preview para que no crashee en Xcode
    NavigationStack {
        TaskDetailView(taskID: UUID())
            .environmentObject(TaskViewModel())
    }
}
