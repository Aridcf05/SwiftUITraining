import SwiftUI

@main
struct SwiftUITrainingApp: App {
    // Instancia única del ViewModel compartida en la app
    @StateObject private var sharedViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Inyección del ViewModel globalmente
                .environmentObject(sharedViewModel)
        }
    }
}
