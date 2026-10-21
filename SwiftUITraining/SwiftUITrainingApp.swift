import SwiftUI

@main
struct SwiftUITrainingApp: App {
    @StateObject private var sharedViewModel = TaskViewModel()
    
    // Detecta qué test de UI se está ejecutando
    private var isTestingTaskCounter: Bool {
        CommandLine.arguments.contains("-UITests_TaskCounter")
    }
    
    private var isTestingTaskManager: Bool {
        CommandLine.arguments.contains("-UITests_TaskManager")
    }
    
    var body: some Scene {
        WindowGroup {
            if isTestingTaskCounter {
                // Cuando corre el test del Contador, abre DIRECTO el contador
                TaskCounterView()
            } else if isTestingTaskManager {
                // Cuando corre el test del Caso Práctico, abre DIRECTO el TaskManager
                TaskManagerView()
            } else {
                // Tu app normal cuando la usas tú en el simulador
                ContentView()
                    .environmentObject(sharedViewModel)
            }
        }
    }
}
