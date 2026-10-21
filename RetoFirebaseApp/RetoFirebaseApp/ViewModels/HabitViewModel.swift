import Foundation
import Combine

@MainActor
final class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var state: ViewState = .idle
    
    func loadHabits(userId: String) async {
        state = .loading
        do {
            habits = try await HabitService.shared.fetchHabits(for: userId)
            state = .success
        } catch {
            state = .error("No se pudieron cargar los hábitos: \(error.localizedDescription)")
        }
    }
    
    func createHabit(userId: String, title: String, description: String) async {
        state = .loading
        let newHabit = Habit(
            userId: userId,
            title: title,
            description: description,
            isCompleted: false,
            createdAt: Date()
        )
        do {
            try await HabitService.shared.addHabit(newHabit)
            await loadHabits(userId: userId)
        } catch {
            state = .error("Error al crear el hábito: \(error.localizedDescription)")
        }
    }
    
    func updateHabit(_ habit: Habit, newTitle: String, newDescription: String) async {
        state = .loading
        var updated = habit
        updated.title = newTitle
        updated.description = newDescription
        do {
            try await HabitService.shared.updateHabit(updated)
            await loadHabits(userId: habit.userId)
        } catch {
            state = .error("Error al actualizar el hábito: \(error.localizedDescription)")
        }
    }
    
    func toggleHabitCompletion(_ habit: Habit) async {
        var updated = habit
        updated.isCompleted.toggle()
        
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index] = updated
        }
        
        do {
            try await HabitService.shared.updateHabit(updated)
            state = .success
        } catch {
            state = .error("No se pudo actualizar el estado del hábito.")
            await loadHabits(userId: habit.userId)
        }
    }
    
    func deleteHabit(_ habit: Habit) async {
        guard let id = habit.id else { return }
        state = .loading
        do {
            try await HabitService.shared.deleteHabit(habitId: id)
            habits.removeAll { $0.id == id }
            state = .success
        } catch {
            state = .error("Error al eliminar el hábito: \(error.localizedDescription)")
        }
    }
}
