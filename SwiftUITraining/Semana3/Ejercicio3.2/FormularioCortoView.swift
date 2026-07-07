import SwiftUI

struct FormularioCortoView: View {
    // Definimos los estados privados para el formulario
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var notificationsEnabled: Bool = false
    
    var body: some View {
        ZStack {
            // Fondo gris nativo para mantener consistencia visual
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Cabecera informativa del entregable
                    VStack(spacing: 6) {
                        Text("EJERCICIO 3.2")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.blue)
                        
                        Text("Formulario con Vista Previa")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.primary)
                    }
                    .padding(.top, 16)
                    
                    // --- SECCIÓN DEL FORMULARIO ---
                    VStack(spacing: 16) {
                        // 1. Agregar nombre con TextField (Criterio: Label claro y uso de $variable)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Nombre Completo")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.secondary)
                            
                            TextField("Ej. Ariana Del Carpio", text: $name)
                                .padding()
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.words)
                        }
                        
                        // 2. Agregar email con teclado adecuado (Criterio: keyboardType y uso de $variable)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Correo Electrónico")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.secondary)
                            
                            TextField("Ej. nombre@correo.com", text: $email)
                                .padding()
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(10)
                                .keyboardType(.emailAddress) // 💡 Teclado optimizado para emails
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                        }
                        
                        Divider()
                            .padding(.vertical, 4)
                        
                        // 3. Agregar toggle de notificaciones (Criterio: Label claro y uso de $variable)
                        Toggle(isOn: $notificationsEnabled) {
                            HStack(spacing: 12) {
                                Image(systemName: notificationsEnabled ? "bell.fill" : "bell.slash.fill")
                                    .foregroundColor(notificationsEnabled ? .blue : .secondary)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Permitir Notificaciones")
                                        .font(.body)
                                        .medium()
                                    Text("Alertas sobre tus entregables de la semana")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .tint(.blue)
                    }
                    .padding(20)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 3)
                    
                    // --- 4. SECCIÓN DEL RESUMEN EN VIVO ---
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Vista previa en vivo")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                        
                        VStack(spacing: 12) {
                            // Criterio: El resumen no muestra textos raros o etiquetas vacías si está vacío
                            HStack {
                                Text("Nombre:")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(name.isEmpty ? "No especificado" : name)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(name.isEmpty ? .secondary.opacity(0.6) : .primary)
                                    .italic(name.isEmpty)
                            }
                            
                            HStack {
                                Text("Email:")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(email.isEmpty ? "No especificado" : email)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(email.isEmpty ? .secondary.opacity(0.6) : .primary)
                                    .italic(email.isEmpty)
                            }
                            
                            HStack {
                                Text("Estado Alertas:")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(notificationsEnabled ? "Activadas" : "Desactivadas")
                                    .font(.caption)
                                    .bold()
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(notificationsEnabled ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
                                    .foregroundColor(notificationsEnabled ? .green : .secondary)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemGroupedBackground))
                        .cornerRadius(12)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 3)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationTitle("Binding en Vivo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Extensión rápida de apoyo para pesos de fuente semánticos
extension Text {
    func medium() -> Text {
        self.fontWeight(.medium)
    }
}

#Preview {
    NavigationStack {
        FormularioCortoView()
    }
}

