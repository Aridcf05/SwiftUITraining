import SwiftUI

struct Semana2View: View {
    var body: some View {
        // En lugar de meter filas vacías, llamamos directamente a tu contenedor ContactsListView
        ContactsListView()
            .navigationTitle("Semana 2")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview corregido y seguro para la Semana 2
#Preview {
    NavigationStack {
        Semana2View()
    }
}
