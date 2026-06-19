import SwiftUI

struct ContactsListView: View {
    
    // PASO 2: Crear un array con 6 contactos (Nombres expresivos)
    let contacts: [Contact] = [
        Contact(name: "Ariana Del Carpio", iconName: "person.crop.circle.fill", phone: "+51 987 654 321"),
        Contact(name: "Carlos Mendoza", iconName: "person.circle", phone: "+51 123 456 789"),
        Contact(name: "Ana Martínez", iconName: "person.crop.circle.badge.checkmark", phone: nil), // Opcional vacío
        Contact(name: "Diego Torres", iconName: "person.circle.fill", phone: "+51 555 444 333"),
        Contact(name: "Elena Gómez", iconName: "person.crop.circle", phone: nil), // Opcional vacío
        Contact(name: "Fernando Ruiz", iconName: "person.circle", phone: "+51 999 888 777")
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 16) {
                
                // Rótulo del Ejercicio (Diseño de la imagen)
                VStack(alignment: .leading, spacing: 4) {
                    Text("EJERCICIO 2.2")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.blue)
                    
                    Text("Lista dinámica con struct, array y ForEach")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                // PASO 3: Renderizar con ForEach de forma dinámica
                VStack(spacing: 12) {
                    ForEach(contacts) { contact in
                        
                        // Diseño limpio para cada fila de contacto
                        HStack(spacing: 16) {
                            Image(systemName: contact.iconName)
                                .font(.title2)
                                .foregroundStyle(.blue)
                                .frame(width: 30)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(contact.name)
                                    .font(.body)
                                    .bold()
                                    .foregroundStyle(.primary)
                                
                                // CRITERIO: El opcional se maneja de forma segura sin romper la vista
                                if let phone = contact.phone {
                                    Text(phone)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                } else {
                                    Text("Sin teléfono")
                                        .font(.footnote)
                                        .foregroundStyle(.tertiary)
                                        .italic()
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(Color(.secondarySystemGroupedBackground)) // Tarjeta blanca
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground).ignoresSafeArea()
        ContactsListView()
    }
}
