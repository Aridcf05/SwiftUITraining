import Foundation
import FirebaseFirestore

final class HabitService {
    static let shared = HabitService()
    private let db = Firestore.firestore()
    private let collectionName = "habits"
    
    private init() {}
    
    func fetchHabits(for userId: String) async throws -> [Habit] {
        let snapshot = try await db.collection(collectionName)
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
        
        let habits = snapshot.documents.compactMap { doc -> Habit? in
            try? doc.data(as: Habit.self)
        }
        return habits.sorted { $0.createdAt > $1.createdAt }
    }
    
    func addHabit(_ habit: Habit) async throws {
        try db.collection(collectionName).addDocument(from: habit)
    }
    
    func updateHabit(_ habit: Habit) async throws {
        guard let id = habit.id else { return }
        try db.collection(collectionName).document(id).setData(from: habit, merge: true)
    }
    
    func deleteHabit(habitId: String) async throws {
        try await db.collection(collectionName).document(habitId).delete()
    }
}
