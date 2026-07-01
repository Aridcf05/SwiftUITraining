import SwiftUI

struct ContactDetailView: View {
    let contact: Contactos
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Avatar principal de presentación
                VStack(spacing: 12) {
                    Text(contact.initials)
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(color: Color.blue.opacity(0.2), radius: 8, x: 0, y: 4)
                    
                    Text(contact.name)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                    
                    Text(contact.role)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(20)
                }
                .padding(.top, 16)
                
                // Bloque de Información de Contacto
                VStack(alignment: .leading, spacing: 16) {
                    Text("Detalles de contacto")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                    
                    // Fila del Correo Electrónico
                    if let email = contact.email {
                        FilaInformacion(icono: "envelope.fill", titulo: "Correo electrónico", valor: email)
                    }
                    
                    // Fila del Teléfono
                    if let phone = contact.phoneNumber {
                        FilaInformacion(icono: "phone.fill", titulo: "Teléfono corporativo", valor: phone)
                    } else {
                        FilaInformacion(icono: "phone.fill", titulo: "Teléfono corporativo", valor: "No registrado", esItalic: true)
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(16)
                
                // Bloque de la Biografía / Perfil Profesional
                if let bio = contact.bio {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Perfil Profesional")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                        
                        Text(bio)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Detalle de Contacto")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Subvista auxiliar reutilizable para mantener un código limpio y ordenado
struct FilaInformacion: View {
    let icono: String
    let titulo: String
    let valor: String
    var esItalic: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icono)
                .font(.body)
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(titulo)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Text(valor)
                    .font(.body)
                    .foregroundColor(esItalic ? .secondary : .primary)
                    .italic(esItalic)
            }
        }
    }
}
