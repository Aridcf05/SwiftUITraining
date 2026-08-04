import Combine
import Foundation

class CharacterListViewModel: ObservableObject {
    @Published var characters: [CharacterDTO] = []
    @Published var errorMessage: String?

    init() {
        loadCharacters()
    }

    func loadCharacters() {
        // 1. Obtener la URL del archivo en el Bundle
        guard let url = Bundle.main.url(forResource: "characters", withExtension: "json") else {
            self.errorMessage = "No se encontró el archivo characters.json en el bundle."
            return
        }

        // 2. Intentar leer y decodificar los datos
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.characters = try decoder.decode([CharacterDTO].self, from: data)
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Error al decodificar: \(error.localizedDescription)"
        }
    }
}

