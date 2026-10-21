import Foundation
import FirebaseAuth
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var userSession: User?
    @Published var state: ViewState = .idle
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        listenToAuthState()
    }
    
    func listenToAuthState() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.userSession = user
            }
        }
    }
    
    func login(email: String, password: String) async {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.isEmpty else {
            state = .error("Por favor, completa tu correo y contraseña.")
            return
        }
        state = .loading
        do {
            let user = try await AuthService.shared.signIn(email: email, password: password)
            userSession = user
            state = .success
        } catch {
            state = .error(mapFirebaseError(error))
        }
    }
    
    func register(email: String, password: String) async {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, password.count >= 6 else {
            state = .error("Ingresa un correo válido y una contraseña de al menos 6 caracteres.")
            return
        }
        state = .loading
        do {
            let user = try await AuthService.shared.signUp(email: email, password: password)
            userSession = user
            state = .success
        } catch {
            state = .error(mapFirebaseError(error))
        }
    }
    
    func logout() {
        do {
            try AuthService.shared.signOut()
            userSession = nil
            state = .idle
        } catch {
            state = .error("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
    
    private func mapFirebaseError(_ error: Error) -> String {
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.wrongPassword.rawValue, AuthErrorCode.invalidCredential.rawValue:
            return "Correo o contraseña incorrectos."
        case AuthErrorCode.invalidEmail.rawValue:
            return "El formato del correo no es válido."
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return "Este correo ya está registrado."
        case AuthErrorCode.networkError.rawValue:
            return "Error de conexión a internet."
        default:
            return error.localizedDescription
        }
    }
}
