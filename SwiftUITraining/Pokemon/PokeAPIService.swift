import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class PokeAPIService {
    static let shared = PokeAPIService()
    private init() {}
    
    // Servicio 1: Obtener la lista
    func fetchPokemonList(limit: Int = 20, offset: Int = 0) async throws -> [PokemonListItem] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return decoded.results
    }
    
    // Servicio 2: Obtener el detalle
    func fetchPokemonDetail(name: String) async throws -> PokemonDetail {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(PokemonDetail.self, from: data)
    }
}
