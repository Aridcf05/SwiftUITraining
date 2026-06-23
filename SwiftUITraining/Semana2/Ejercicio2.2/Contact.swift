import Foundation

// PASO 1: Crear el struct que sea Identifiable
struct Contact: Identifiable {
    let id = UUID() // Identificador único requerido por el protocolo Identifiable
    let name: String
    let iconName: String
    let phone: String? // PASO 4: Propiedad opcional (puede ser String o nil)
}
