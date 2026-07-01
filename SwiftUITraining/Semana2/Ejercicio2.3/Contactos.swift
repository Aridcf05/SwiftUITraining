import Foundation

struct Contactos: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let name: String
    let role: String
    let initials: String
    // Nuevos campos informativos:
    let email: String?
    let phoneNumber: String?
    let bio: String?
}
