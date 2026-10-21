import SwiftUI
import FirebaseAuth

struct HabitListView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var habitViewModel = HabitViewModel()
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @State private var showingAddHabit = false
    @State private var habitToEdit: Habit?
    
    var userId: String {
        authViewModel.userSession?.uid ?? ""
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if habitViewModel.state == .loading && habitViewModel.habits.isEmpty {
                    ProgressView("Cargando tus hábitos...")
                } else if habitViewModel.habits.isEmpty {
                    ContentUnavailableView(
                        "Sin hábitos todavía",
                        systemImage: "sparkles",
                        description: Text("Toca el botón + arriba a la derecha para registrar tu primer hábito.")
                    )
                } else {
                    List {
                        ForEach(habitViewModel.habits) { habit in
                            HStack(spacing: 14) {
                                Button {
                                    Task {
                                        await habitViewModel.toggleHabitCompletion(habit)
                                    }
                                } label: {
                                    Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .font(.title2)
                                        .foregroundStyle(habit.isCompleted ? .green : .secondary)
                                }
                                .buttonStyle(.plain)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(habit.title)
                                        .font(.headline)
                                        .strikethrough(habit.isCompleted, color: .secondary)
                                        .foregroundStyle(habit.isCompleted ? .secondary : .primary)
                                    
                                    if !habit.description.isEmpty {
                                        Text(habit.description)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                
                                Spacer()
                                
                                Button {
                                    habitToEdit = habit
                                } label: {
                                    Image(systemName: "pencil")
                                        .foregroundStyle(.blue)
                                }
                                .buttonStyle(.borderless)
                            }
                            .padding(.vertical, 4)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    Task {
                                        await habitViewModel.deleteHabit(habit)
                                    }
                                } label: {
                                    Label("Eliminar", systemImage: "trash")
                                }
                                
                                Button {
                                    habitToEdit = habit
                                } label: {
                                    Label("Editar", systemImage: "pencil")
                                }
                                .tint(.orange)
                            }
                        }
                    }
                    .refreshable {
                        await habitViewModel.loadHabits(userId: userId)
                    }
                }
            }
            .navigationTitle("Mis Hábitos")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                            .foregroundStyle(isDarkMode ? .yellow : .orange)
                    }
                    
                    Button(role: .destructive) {
                        authViewModel.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                HabitFormView(viewModel: habitViewModel, userId: userId)
            }
            .sheet(item: $habitToEdit) { habit in
                HabitFormView(viewModel: habitViewModel, userId: userId, habitToEdit: habit)
            }
            .alert(
                "Aviso",
                isPresented: Binding(
                    get: {
                        if case .error = habitViewModel.state { return true }
                        return false
                    },
                    set: { _ in habitViewModel.state = .idle }
                )
            ) {
                Button("Aceptar", role: .cancel) {}
            } message: {
                if case .error(let msg) = habitViewModel.state {
                    Text(msg)
                }
            }
            .task {
                if !userId.isEmpty {
                    await habitViewModel.loadHabits(userId: userId)
                }
            }
        }
    }
}
