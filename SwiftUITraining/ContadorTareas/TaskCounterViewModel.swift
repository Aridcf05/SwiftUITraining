import Foundation
import Combine

final class TaskCounterViewModel: ObservableObject {
    @Published private(set) var count: Int = 0
    @Published var errorMessage: String?
    
    func increment() {
        count += 1
        errorMessage = nil
    }
    
    // Caso límite (Edge case): evitar números negativos
    func decrement() {
        guard count > 0 else {
            errorMessage = "No se puede decrementar por debajo de 0"
            return
        }
        count -= 1
        errorMessage = nil
    }
}

