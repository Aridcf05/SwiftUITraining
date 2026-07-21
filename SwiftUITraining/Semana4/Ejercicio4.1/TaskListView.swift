import SwiftUI

struct TaskListView: View {
    // Pasos 2: Leer el ViewModel compartido desde el entorno (en lugar de crearlo localmente)
    @EnvironmentObject var viewModel: TaskViewModel
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                if viewModel.tasks.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.dashed")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                        Text("¡No tienes tareas pendientes!")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    List {
                        ForEach(viewModel.tasks) { task in
                            // Pasos 3: Al pulsar, navegamos a la pantalla de detalle de la tarea
                            NavigationLink(destination: TaskDetailView(taskID: task.id)) {
                                HStack {
                                    Button(action: {
                                        viewModel.toggleTaskCompletion(task: task)
                                    }) {
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(task.isCompleted ? .green : .blue)
                                            .font(.title3)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Text(task.title)
                                        .strikethrough(task.isCompleted)
                                        .foregroundColor(task.isCompleted ? .secondary : .primary)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.deleteTask(at: indexSet)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Mis Tareas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                // Modificado para que la modal consuma el Environment de forma segura si es necesario
                NewTaskView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    // Criterio: La app no crashea en previews/pruebas por falta de inyección
    NavigationStack {
        TaskListView()
            .environmentObject(TaskViewModel())
    }
}
