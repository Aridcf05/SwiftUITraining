import SwiftUI

struct HabitFormView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: HabitViewModel
    let userId: String
    var habitToEdit: Habit?
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    var isEditing: Bool { habitToEdit != nil }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Información del Hábito") {
                    TextField("Título (ej. Leer 20 minutos)", text: $title)
                    TextField("Descripción opcional", text: $description, axis: .vertical)
                        .lineLimit(3...5)
                }
            }
            .navigationTitle(isEditing ? "Editar Hábito" : "Nuevo Hábito")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(isEditing ? "Guardar" : "Crear") {
                        Task {
                            if let habit = habitToEdit {
                                await viewModel.updateHabit(
                                    habit,
                                    newTitle: title.trimmingCharacters(in: .whitespaces),
                                    newDescription: description.trimmingCharacters(in: .whitespaces)
                                )
                            } else {
                                await viewModel.createHabit(
                                    userId: userId,
                                    title: title.trimmingCharacters(in: .whitespaces),
                                    description: description.trimmingCharacters(in: .whitespaces)
                                )
                            }
                            dismiss()
                        }
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                if let habit = habitToEdit {
                    title = habit.title
                    description = habit.description
                }
            }
        }
    }
}
