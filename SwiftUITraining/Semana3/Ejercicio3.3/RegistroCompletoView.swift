import SwiftUI

struct RegistroCompletoView: View {
    // 2. Estados privados para capturar las credenciales y el rol
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedRole: String = "iOS Developer"
    
    // Lista de roles disponibles para el Picker
    let roles = ["UX/UI Designer", "iOS Developer", "Cybersecurity Analyst", "Product Owner"]
    
    // 3. REGLA DE VALIDACIÓN CENTRALIZADA (Criterio: computed var)
    private var isValid: Bool {
        // Reglas simples y legibles: campos no vacíos y formato básico de email
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") &&
        email.contains(".") &&
        password.count >= 6
    }
    
    var body: some View {
        // 1. Crear un Form con Section
        Form {
            // Sección 1: Datos Personales
            Section(header: Text("Información Personal")) {
                TextField("Nombre Completo", text: $name)
                    .textInputAutocapitalization(.words)
                
                TextField("Correo Electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            
            // Sección 2: Credenciales de Acceso
            Section(
                header: Text("Seguridad"),
                footer: Text("La contraseña debe tener al menos 6 caracteres.")
                    .font(.caption2)
                    .foregroundColor(password.count >= 6 || password.isEmpty ? .secondary : .red)
            ) {
                // Criterio: El password usa campo seguro (SecureField)
                SecureField("Contraseña", text: $password)
            }
            
            // Sección 3: Perfil Profesional dentro del formulario
            Section(header: Text("Rol en el Equipo")) {
                Picker("Selecciona tu rol", selection: $selectedRole) {
                    ForEach(roles, id: \.self) { role in
                        Text(role).tag(role)
                    }
                }
                .pickerStyle(.navigationLink) // Despliega una subpantalla elegante nativa
            }
            
            // Sección 4: Botón de Acción y Mensajes Guía
            Section {
                VStack(spacing: 12) {
                    // Botón de Registro
                    Button(action: ejecutarRegistro) {
                        Text("Registrar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 4)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    // 4. Criterio: Deshabilitar Registrar si la data es inválida
                    .disabled(!isValid)
                    
                    // Criterio: La pantalla explica visualmente qué falta completar
                    if !isValid {
                        ExplicacionValidacionView(name: name, email: email, password: password)
                    }
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.clear) // Hace que el bloque del botón flote limpiamente
        }
        .navigationTitle("Registro Completo")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Criterio: La validación NO está duplicada en el botón (el botón confía ciegamente en .disabled)
    private func ejecutarRegistro() {
        print("Registro exitoso para: \(name) con el rol de \(selectedRole)")
    }
}

// Subvista auxiliar para explicar visualmente los requisitos pendientes sin sobrecargar el código
struct ExplicacionValidacionView: View {
    let name: String
    let email: String
    let password: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Falta completar:")
                .font(.caption)
                .bold()
                .foregroundColor(.secondary)
            
            Group {
                if name.trimmingCharacters(in: .whitespaces).isEmpty {
                    Label {
                        Text("Nombre completo requerido")
                    } icon: {
                        Image(systemName: "xmark.circle")
                    }
                }
                if !email.contains("@") || !email.contains(".") {
                    Label {
                        Text("Correo electrónico válido (ej. usuario@dominio.com)")
                    } icon: {
                        Image(systemName: "xmark.circle")
                    }
                }
                if password.count < 6 {
                    Label {
                        Text("Contraseña de mínimo 6 caracteres")
                    } icon: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
            .font(.caption2)
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(8)
    }
}

#Preview {
    NavigationStack {
        RegistroCompletoView()
    }
}
