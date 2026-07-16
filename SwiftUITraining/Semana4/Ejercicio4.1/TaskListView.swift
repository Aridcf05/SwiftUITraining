import SwiftUI

struct TaskListView: View {
    // Inicializamos el ViewModel con @StateObject en la pantalla raíz del flujo
    @StateObject private var viewModel = TaskViewModel()
    
    // Control de apertura del sheet modal
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
                        .onDelete { indexSet in
                            viewModel.deleteTask(at: indexSet)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Mis Tareas")
            .toolbar {
                // Botón "+" en el toolbar para abrir el modal
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // Presentación modal del sheet
            .sheet(isPresented: $showSheet) {
                NewTaskView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskListView()
    }
}
