import SwiftUI

struct AuthView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(.blue)
                    
                    Text(isLoginMode ? "Bienvenido de nuevo" : "Crea tu cuenta")
                        .font(.title.bold())
                    
                    Text("Gestiona tus hábitos diarios en la nube")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 20)
                
                Picker("Modo", selection: $isLoginMode) {
                    Text("Iniciar Sesión").tag(true)
                    Text("Registrarse").tag(false)
                }
                .pickerStyle(.segmented)
                .onChange(of: isLoginMode) { _, _ in
                    authViewModel.state = .idle
                }
                
                VStack(spacing: 14) {
                    TextField("Correo electrónico", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    SecureField("Contraseña (mín. 6 caracteres)", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                if case .error(let message) = authViewModel.state {
                    Text(message)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    Task {
                        if isLoginMode {
                            await authViewModel.login(email: email, password: password)
                        } else {
                            await authViewModel.register(email: email, password: password)
                        }
                    }
                } label: {
                    HStack {
                        if authViewModel.state == .loading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text(isLoginMode ? "Ingresar" : "Crear Cuenta")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(authViewModel.state == .loading)
                
                Spacer()
            }
            .padding(24)
            .navigationTitle("Mis Hábitos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
