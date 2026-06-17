
import SwiftUI

struct ContactRowView: View {
   
    let initials: String
    let name: String
    let role: String
    
    var body: some View {
        HStack(spacing: 16) {
            
         
            Text(initials)
                .font(.headline)
                .bold()
                .foregroundStyle(.white) // Texto blanco fijo para que resalte
                .frame(width: 46, height: 46)
                .background(Color.blue) // Fondo azul para el avatar
                .clipShape(Circle()) // Corta el fondo en un círculo perfecto
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.body)
                    .bold()
                    .foregroundStyle(.primary) // Se adapta automáticamente a modo claro/oscuro
                
                Text(role)
                    .font(.subheadline)
                    .foregroundStyle(.secondary) // Texto grisáceo sutil para el cargo
            }
            
            Spacer() // Empuja el contenido a la izquierda, dejando el resto de la fila libre
        }
        .padding(.vertical, 4) // Paso 4: Margen vertical interno para que la fila "respire"
    }
}


struct ContactsListView: View {
    var body: some View {
        NavigationStack {
            List {
                // Paso 4: Renderizamos las 4 filas escritas manualmente para probar el componente
                ContactRowView(initials: "AM", name: "Ana Martínez", role: "UX/UI Designer")
                ContactRowView(initials: "CC", name: "Carlos Contreras", role: "iOS Developer")
                ContactRowView(initials: "LF", name: "Luis Flores", role: "Cybersecurity Analyst")
                ContactRowView(initials: "SR", name: "Sofia Rodríguez", role: "Product Owner")
            }
            // Paso 4: Modificadores de estilo nativo para configurar márgenes y comportamiento de la lista
            .listStyle(.plain) // Estilo limpio sin los bloques grises pesados del modo "grouped"
            .navigationTitle("Contactos") // Título superior de la pantalla
        }
    }
}
#Preview {
    // El Preview de Xcode te permite renderizar la lista completa directamente
    ContactsListView()
}
