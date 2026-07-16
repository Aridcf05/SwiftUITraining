import SwiftUI

struct NewTaskView: View {
    // Conectamos el ViewModel que se pasa como dependencia
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var taskTitle: String = ""
    @Environment(\.dismiss) var dismiss // Para poder cerrar la modal
    
    // Validación de texto vacío
    private var isFormValid: Bool {
        !taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nueva Tarea")) {
                    TextField("Escribe el nombre de la tarea...", text: $taskTitle)
                        .textInputAutocapitalization(.sentences)
                }
            }
            .navigationTitle("Añadir Tarea")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Botón para cancelar
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                // Botón para guardar con validación integrada
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        viewModel.addTask(title: taskTitle)
                        dismiss() // El sheet se cierra al guardar
                    }
                    .bold()
                    .disabled(!isFormValid) // No se puede guardar una tarea vacía
                }
            }
        }
    }
}
