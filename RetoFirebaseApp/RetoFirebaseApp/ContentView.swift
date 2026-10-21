import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                HabitListView(authViewModel: authViewModel)
            } else {
                AuthView(authViewModel: authViewModel)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
